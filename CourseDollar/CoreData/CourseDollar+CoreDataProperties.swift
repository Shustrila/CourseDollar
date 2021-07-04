//
//  CourseDollar+CoreDataProperties.swift
//  CourseDollar
//
//  Created by sasha on 28.06.2021.
//
//

import Foundation
import CoreData


extension CourseDollar {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CourseDollar> {
        return NSFetchRequest<CourseDollar>(entityName: "CourseDollar")
    }
    
    @NSManaged public var course: String?
    @NSManaged public var date: String?
    @NSManaged public var id: String?

}

extension CourseDollar : Identifiable {

}
