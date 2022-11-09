//
//  CoreDataStack.swift
//  EventManager
//
//  Created by Julia Frederico on 09/11/22.
//

import CoreData

enum CoreDataStack {

    static let container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: Strings.appName)
        
        container.loadPersistentStores() { description, error in
            if let error = error as NSError? {
                fatalError("Unresolved error: \(error)")
            }
        }

        return container
    }()

    static var context: NSManagedObjectContext { return container.viewContext }
    
    static func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                NSLog("Error saving context \(context)")
            }
        }
    }

}
