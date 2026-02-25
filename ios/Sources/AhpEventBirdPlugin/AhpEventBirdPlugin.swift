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
        CAPPluginMethod(name: "completeProgressActivity", returnType: CAPPluginReturnPromise)
    ]

    private var pendingSaveCredentialsCall: [CAPPluginCall] = []

    @objc func saveCredentials(_ call: CAPPluginCall) {
        let username = call.getString("username") ?? ""
        let password = call.getString("password") ?? ""

        NotificationCenter.default.post(name: Notification.Name("AhpSaveCredentials"), object: ["username": username, "password": password])
        pendingSaveCredentialsCall.append(call)
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
