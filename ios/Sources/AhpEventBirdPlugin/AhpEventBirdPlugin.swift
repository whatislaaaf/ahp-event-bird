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
        CAPPluginMethod(name: "getFCMToken", returnType: CAPPluginReturnPromise)
    ]

    private var pendingSaveCredentialsCall: [CAPPluginCall] = []
    private var pendingFCMCalls: [CAPPluginCall] = []
    private var savedFCMToken: String?

    // Called by Capacitor when the bridge is ready and the plugin is set up.
    // At this point it is safe to access the bridge and resolve any pending calls.
    override public func load() {
        // Observe future token deliveries from AppDelegate.
        NotificationCenter.default.addObserver(
            forName: Notification.Name("FCMTokenReceived"),
            object: nil,
            queue: .main
        ) { [weak self] notification in
            if let token = notification.object as? String {
                print("[Native] FCMTokenReceived notification — applying token.")
                self?.setFCMToken(token)
            }
        }

        // In case AppDelegate already received the token before load() was called
        // (e.g. Firebase fired didReceiveRegistrationToken very early at startup),
        // pick it up from UserDefaults where AppDelegate stashed it.
        if let token = UserDefaults.standard.string(forKey: "latestFCMToken") {
            print("[Native] load() — found cached FCM token in UserDefaults, applying now.")
            setFCMToken(token)
        }
    }

    @objc private func onFCMTokenReceived(_ notification: Notification) {
        if let token = notification.object as? String {
            print("[Native] FCMTokenReceived notification — applying token.")
            setFCMToken(token)
        }
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
