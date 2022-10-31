//
//  Task+Convenience.swift
//  TaskCD
//
//  Created by Julia Frederico on 31/10/22.
//

import CoreData

extension Task {
    
    @discardableResult convenience init(name: String, notes: String? = nil, dueDate: Date? = nil, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
        self.notes = notes
        self.dueDate = dueDate
    }
    
}
