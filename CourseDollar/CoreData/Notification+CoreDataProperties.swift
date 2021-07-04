//
//  Notification+CoreDataProperties.swift
//  CourseDollar
//
//  Created by sasha on 28.06.2021.
//
//

import Foundation
import CoreData


extension Notification {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Notification> {
        return NSFetchRequest<Notification>(entityName: "Notification")
    }

    @NSManaged public var oldCourse: String?
    @NSManaged public var newCourse: String?
    @NSManaged public var dateUpdate: String?
    @NSManaged public var looked: Bool?
}

extension Notification : Identifiable {

}
