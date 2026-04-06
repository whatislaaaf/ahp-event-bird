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
        CAPPluginMethod(name: "signInWithGoogle", returnType: CAPPluginReturnPromise)
    ]

    private var pendingSaveCredentialsCall: [CAPPluginCall] = []
    private var pendingFCMCalls: [CAPPluginCall] = []
    private var savedFCMToken: String?
    private var pendingGoogleSignInCall: CAPPluginCall?

    @objc func signInWithGoogle(_ call: CAPPluginCall) {
        pendingGoogleSignInCall = call
        NotificationCenter.default.post(name: Notification.Name("AhpSignInWithGoogle"), object: nil)
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
