import Foundation
import CoreData

class DataBaseManager {
    // MARK: - Singleton
    
    static let shared = DataBaseManager()
    
    init() { }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CourseDollar")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            guard let error = error as NSError? else { return }
            
            fatalError("Unresolved error \(error), \(error.userInfo)")
        })

        return container
    }()
    // MARK: - View Context
    
    
    lazy var context: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if !context.hasChanges { return }
        
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}
