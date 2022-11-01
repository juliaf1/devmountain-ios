//
//  CoreDataStack.swift
//  AlarmCoreData
//
//  Created by Julia Frederico on 01/11/22.
//

import CoreData

enum CoreDataStack {
    
    static let container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: Strings.appName)
        
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Unresolved error loading persistent stores: \(error)")
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
                NSLog("Error saving context \(context): \(error)")
            }
        }
    }
    
}
