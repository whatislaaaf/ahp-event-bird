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

    @objc func saveCredentials(_ call: CAPPluginCall) {
        let username = call.getString("username") ?? ""
        let password = call.getString("password") ?? ""

        NotificationCenter.default.post(name: Notification.Name("AhpSaveCredentials"), object: ["username": username, "password": password])
        pendingSaveCredentialsCall.append(call)
    }

    @objc func getFCMToken(_ call: CAPPluginCall) {
        if let token = savedFCMToken {
            print("[Native] JS called getFCMToken, passing the token.")
            call.resolve(["value": token])
        } else {
            print("[Native] JS called getFCMToken, but token not ready. Queuing callback.")
            pendingFCMCalls.append(call)
        }
    }

    @objc public func setFCMToken(_ token: String) {
        print("[Native] Setting FCM token in plugin")
        self.savedFCMToken = token

        for call in pendingFCMCalls {
            call.resolve(["value": token])
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
