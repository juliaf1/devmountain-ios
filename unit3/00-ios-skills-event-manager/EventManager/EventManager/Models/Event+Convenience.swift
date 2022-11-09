//
//  Event+Convenience.swift
//  EventManager
//
//  Created by Julia Frederico on 09/11/22.
//

import CoreData

extension Event {
    
    @discardableResult convenience init(name: String, date: Date? = Date(), context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
        self.date = date
    }
    
}
