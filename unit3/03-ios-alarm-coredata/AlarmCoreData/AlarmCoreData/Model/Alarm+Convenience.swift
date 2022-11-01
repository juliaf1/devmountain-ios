//
//  Alarm+Convenience.swift
//  AlarmCoreData
//
//  Created by Julia Frederico on 01/11/22.
//

import CoreData

extension Alarm {
    
    @discardableResult convenience init(title: String, fireDate: Date, enabled: Bool, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.title = title
        self.fireDate = fireDate
        self.enabled = enabled
        self.uuiString = UUID().uuidString
    }
    
}
