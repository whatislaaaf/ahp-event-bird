import Foundation

@objc public class AhpEventBird: NSObject {
    @objc public func echo(_ value: String) -> String {
        print(value)
        return value
    }
}
