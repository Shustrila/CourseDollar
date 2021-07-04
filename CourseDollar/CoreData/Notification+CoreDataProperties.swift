//
//  Notification+CoreDataProperties.swift
//  CourseDollar
//
//  Created by sasha on 04.07.2021.
//
//

import Foundation
import CoreData


extension Notification {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Notification> {
        return NSFetchRequest<Notification>(entityName: "Notification")
    }

    @NSManaged public var dateUpdate: Date?
    @NSManaged public var newCourse: String?
    @NSManaged public var oldCourse: String?
    @NSManaged public var looked: Bool
    @NSManaged public var id: UUID

}

extension Notification : Identifiable {

}
