import Foundation
import Capacitor

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(AhpEventBirdPlugin)
public class AhpEventBirdPlugin: CAPPlugin, CAPBridgedPlugin {
    public let identifier = "AhpEventBirdPlugin"
    public let jsName = "AhpEventBird"

    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "saveCredentials", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "startProgressActivity", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "completeProgressActivity", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "getFCMToken", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "clearFCMToken", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "signInWithGoogle", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "signInWithGoogle", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "signInWithApple", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "pauseProgressActivity", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "resumeProgressActivity", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "syncWidgetData", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "resetPatchAlertShownToday", returnType: CAPPluginReturnPromise),
    ]

    private var pendingSaveCredentialsCall: [CAPPluginCall] = []
    private var pendingFCMCalls: [CAPPluginCall] = []
    private var savedFCMToken: String?
    private var pendingGoogleSignInCall: CAPPluginCall?
    private var pendingAppleSignInCall: CAPPluginCall?

    @objc func syncWidgetData(_ call: CAPPluginCall) {
        let tasks = call.getString("tasks") ?? "[]"
        let totalCount = call.getInt("totalCount") ?? 0
        let completedCount = call.getInt("completedCount") ?? 0
        let focusTaskName = call.getString("focusTaskName")
        let focusStartedAt = call.getString("focusStartedAt")

        NotificationCenter.default.post(
            name: Notification.Name("AhpSyncWidgetData"),
            object: [
                "tasks": tasks,
                "totalCount": totalCount,
                "completedCount": completedCount,
                "focusTaskName": focusTaskName as Any,
                "focusStartedAt": focusStartedAt as Any,
            ])
        call.resolve()
    }

    @objc func pauseProgressActivity(_ call: CAPPluginCall) {
        NotificationCenter.default.post(name: Notification.Name("AhpPauseProgressActivity"), object: nil)
        call.resolve()
    }

    @objc func resumeProgressActivity(_ call: CAPPluginCall) {
        let startedAt = call.getString("startedAt") ?? ""
        NotificationCenter.default.post(name: Notification.Name("AhpResumeProgressActivity"), object: ["startedAt": startedAt])
        call.resolve()
    }

    @objc func signInWithGoogle(_ call: CAPPluginCall) {
        pendingGoogleSignInCall = call
        NotificationCenter.default.post(name: Notification.Name("AhpSignInWithGoogle"), object: nil)
    }

    @objc func signInWithApple(_ call: CAPPluginCall) {
        pendingAppleSignInCall = call
        NotificationCenter.default.post(name: Notification.Name("AhpSignInWithApple"), object: nil)
    }

    @objc public func appleSignInResult(idToken: String, email: String, displayName: String) {
        pendingAppleSignInCall?.resolve([
            "idToken": idToken,
            "email": email,
            "displayName": displayName
        ])
        pendingAppleSignInCall = nil
    }

    @objc public func appleSignInError(_ message: String) {
        pendingAppleSignInCall?.reject(message)
        pendingAppleSignInCall = nil
    }

    @objc public func googleSignInResult(idToken: String, email: String, displayName: String) {
        pendingGoogleSignInCall?.resolve([
            "idToken": idToken,
            "email": email,
            "displayName": displayName
        ])
        pendingGoogleSignInCall = nil
    }

    @objc public func googleSignInError(_ message: String) {
        pendingGoogleSignInCall?.reject(message)
        pendingGoogleSignInCall = nil
    }

    @objc func saveCredentials(_ call: CAPPluginCall) {
        let username = call.getString("username") ?? ""
        let password = call.getString("password") ?? ""

        NotificationCenter.default.post(name: Notification.Name("AhpSaveCredentials"), object: ["username": username, "password": password])
        pendingSaveCredentialsCall.append(call)
    }

    @objc func getFCMToken(_ call: CAPPluginCall) {
        let deviceId = UIDevice.current.identifierForVendor?.uuidString

        if let token = savedFCMToken {
            print("[Native] JS called getFCMToken, passing the token.")
            call.resolve(["fcmToken": token, "deviceId": deviceId])
        } else {
            print("[Native] JS called getFCMToken, but token not ready. Queuing callback.")
            pendingFCMCalls.append(call)
        }
    }

    @objc public func clearFCMToken(_ call: CAPPluginCall) {
        self.savedFCMToken = nil
        call.resolve()
    }

    @objc public func setFCMToken(_ token: String) {
        print("[Native] Setting FCM token in plugin")

        self.savedFCMToken = token
        let deviceId = UIDevice.current.identifierForVendor?.uuidString

        for call in pendingFCMCalls {
            call.resolve(["fcmToken": token, "deviceId": deviceId])
        }
        pendingFCMCalls.removeAll()
    }

    @objc public func notifyAppUpdateRequired(
        kind: String,
        currentVersion: String,
        appStoreVersion: String,
        appStoreUrl: String,
        releaseNotes: String?
    ) {
        var payload: [String: Any] = [
            "kind": kind,
            "currentVersion": currentVersion,
            "appStoreVersion": appStoreVersion,
            "appStoreUrl": appStoreUrl,
        ]
        if let releaseNotes = releaseNotes {
            payload["releaseNotes"] = releaseNotes
        }
        notifyListeners("appUpdateRequired", data: payload)
    }

    @objc func resetPatchAlertShownToday(_ call: CAPPluginCall) {
        NotificationCenter.default.post(name: Notification.Name("AhpResetPatchAlertShownToday"), object: nil)
        call.resolve()
    }

    @objc func startProgressActivity(_ call: CAPPluginCall) {
        let progressId = call.getString("progressId") ?? ""
        let taskName = call.getString("taskName") ?? ""
        let startedAt = call.getString("startedAt") ?? ""

        NotificationCenter.default.post(
            name: Notification.Name("AhpStartProgressActivity"),
            object: [
                "progressId": progressId,
                "taskName": taskName,
                "startedAt": startedAt,
            ])
        call.resolve()
    }

    @objc func completeProgressActivity(_ call: CAPPluginCall) {
        let progressId = call.getString("progressId") ?? ""
        let taskName = call.getString("taskName") ?? ""
        let startedAt = call.getString("startedAt") ?? ""

        NotificationCenter.default.post(
            name: Notification.Name("AhpCompleteProgressActivity"),
            object: [
                "progressId": progressId,
                "taskName": taskName,
                "startedAt": startedAt,
            ])
        call.resolve()
    }

    @objc public func saveCredentialsResult(_ isSuccess: Bool) {
        print("[Native] saveCredentialsResult()")

        for call in pendingSaveCredentialsCall {
            call.resolve(["isSuccess": isSuccess])
        }
        pendingSaveCredentialsCall.removeAll()
    }
}
