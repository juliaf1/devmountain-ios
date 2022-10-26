//
//  ListItem+Convenience.swift
//  ShoppingList
//
//  Created by Julia Frederico on 26/10/22.
//

import Foundation
import CoreData

extension ListItem {
    // ListItem class is generated behind the scenes by Core Data
    // All Core Data models are subclasses of NSManagedObject
    // All NSManagedObjects live in the NSManagedObjectContext
    
    convenience init(name: String, amount: String?, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
        self.amount = amount
    }

}
