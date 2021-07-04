import Foundation
import CoreData


extension DataBaseManager {
    public func getAllNotifications() -> [Notification] {
        let fetchRequest = NSFetchRequest<Notification>(entityName: "Notification")
        guard let objects = try? context.fetch(fetchRequest) else { return [] }
        return objects
    }
    
    public func createNotification(
        newCourse: String,
        oldCourse: String
    ) {
        let formatter = DateFormatter()
        let notification = Notification(context: context)
        
        formatter.dateFormat = "dd.MM.yyy"

        notification.id = UUID()
        notification.dateUpdate = Date()
        notification.newCourse = newCourse
        notification.oldCourse = oldCourse
        notification.looked = false
        
        saveContext()
    }
    
    public func lookedNotification(byId: UUID) {
        let fetchRequest: NSFetchRequest = NSFetchRequest<Notification>(entityName: "Notification")
        guard let objects: [Notification] = try? context.fetch(fetchRequest) else { return }
        guard let object = objects.filter({ $0.id == byId }) .first else { return }
        
        object.looked = true
        saveContext()
    }
    
    public func deleteNotification(byId: UUID) {
        let fetchRequest: NSFetchRequest = NSFetchRequest<Notification>(entityName: "Notification")
        guard let objects: [Notification] = try? context.fetch(fetchRequest) else { return }
        guard let object = objects.filter({ $0.id == byId }) .first else { return }
        
        context.delete(object)
        saveContext()
    }
}
