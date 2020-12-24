//
//  Task+CoreDataProperties.swift
//  habit_tracker_03
//
//  Created by Kyle Arcilla on 11/7/20.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var isDone: Bool
    @NSManaged public var name: String?
    @NSManaged public var parentCategory: Category?

}

extension Task : Identifiable {

}
