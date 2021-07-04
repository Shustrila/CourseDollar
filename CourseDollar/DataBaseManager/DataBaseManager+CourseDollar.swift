import Foundation
import CoreData

extension DataBaseManager {
    // MARK: - Public
    
    public func addCourseDollar(_ courses: [CourseDollarDomain]) {
        for course in courses {
            let courseDollar = CourseDollar(context: context)

            courseDollar.id = course.id
            courseDollar.course = course.course
            courseDollar.date = course.date
            
            saveContext()
        }
    }
    
    public func getAllCourseDollar() -> [CourseDollar] {
        let fetchRequest = NSFetchRequest<CourseDollar>(entityName: "CourseDollar")
        guard let objects = try? context.fetch(fetchRequest) else { return [] }
        return objects
    }
    
    public func deleteAllCourseDollar() {
        let fetchRequest = NSFetchRequest<CourseDollar>(entityName: "CourseDollar")
        guard let objects = try? context.fetch(fetchRequest) else { return }
        
        for object in objects {
            context.delete(object)
        }
    }
}
