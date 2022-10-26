//
//  CoreDataStack.swift
//  ShoppingList
//
//  Created by Julia Frederico on 26/10/22.
//

import Foundation
import CoreData

enum CoreDataStack {

    static let container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ShoppingList")
        
        container.loadPersistentStores() { description, error in
            if let error = error as NSError? {
                fatalError("Unresolved error: \(error)")
            }
        }

        return container
    }()

    static var context: NSManagedObjectContext { return container.viewContext }
}
