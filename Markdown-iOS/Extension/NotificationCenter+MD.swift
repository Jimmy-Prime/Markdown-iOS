import Foundation

extension NotificationCenter {
    @discardableResult func addObserver(forName name: NSNotification.Name?, using block: @escaping (Notification) -> Void) -> NSObjectProtocol {
        return addObserver(forName: name, object: nil, queue: nil, using: block)
    }
}
