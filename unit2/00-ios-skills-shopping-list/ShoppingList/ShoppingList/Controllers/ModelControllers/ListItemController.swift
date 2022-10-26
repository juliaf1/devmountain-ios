//
//  ListItemController.swift
//  ShoppingList
//
//  Created by Julia Frederico on 25/10/22.
//

import Foundation
import CoreData

class ListItemController {
    
    // MARK: - Properties and shared instance
    
    static let shared = ListItemController()
    
    var items: [ListItem] {
        let request: NSFetchRequest<ListItem> = ListItem.fetchRequest()
        
        do {
            return try CoreDataStack.context.fetch(request)
        } catch {
            print("Error fetching List Items: \(error)")
            return []
        }
    }
    
    // MARK: - CRUD
    
    func add(_ item: ListItem) {
        saveToPersistentStorage()
    }
    
    func delete(_ item: ListItem) {
        if let moc = item.managedObjectContext {
            moc.delete(item)
            saveToPersistentStorage()
        }
    }
    
    func toggleCheck(of item: ListItem) {
        item.checked = !item.checked
        saveToPersistentStorage()
    }
    
    // MARK: - Persistence
    
    func saveToPersistentStorage() {
        do {
            try CoreDataStack.context.save()
        } catch let error {
            print(error)
        }
    }

}
