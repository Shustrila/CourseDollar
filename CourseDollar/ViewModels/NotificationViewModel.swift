import Foundation
import UIKit


protocol NotificationViewModelProtocol: NSObject {
    var notifications: [Notification] { get }
    
    func getNotification() -> Void
    func lookedNotification(index: IndexPath) -> Void
    func deleteNotification(index: IndexPath) -> Void

    func getNotificationCount() -> Int
    func getNotificationCell(_: UITableView, indexPath: IndexPath) -> UITableViewCell
}


class NotificationViewModel: NSObject {
    // MARK: - Properties

    @objc dynamic var notifications: [Notification] = []
}


extension NotificationViewModel: NotificationViewModelProtocol {
    func getNotification() {
        notifications = DataBaseManager.shared
            .getAllNotifications()
            .reversed()
    }
    
    func lookedNotification(index: IndexPath) {
        let notification = notifications[index.row]
        
        DataBaseManager.shared.lookedNotification(byId: notification.id)
        getNotification()
        NotificationCenter.default.post(name: .didUpdateNotification, object: nil)
    }
    
    func deleteNotification(index: IndexPath) {
        let notification = notifications[index.row]

        DataBaseManager.shared.deleteNotification(byId: notification.id)
        getNotification()
        NotificationCenter.default.post(name: .didUpdateNotification, object: nil)
    }
    
    func getNotificationCount() -> Int {
        return notifications.count
    }
    
    func getNotificationCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
        cell.item = notifications[indexPath.row]
        return cell
    }
}
