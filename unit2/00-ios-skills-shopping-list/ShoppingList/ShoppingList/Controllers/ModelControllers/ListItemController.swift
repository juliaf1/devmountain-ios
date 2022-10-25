//
//  ListItemController.swift
//  ShoppingList
//
//  Created by Julia Frederico on 25/10/22.
//

import Foundation

class ListItemController {
    
    // MARK: - Properties and shared instance
    
    static let shared = ListItemController()
    
    var items = [ListItem]()
    
    // MARK: - CRUD
    
    func add(_ item: ListItem) {
        items.append(item)
        saveToPersistentStorage()
    }
    
    func delete(_ item: ListItem) {
        guard let index = items.firstIndex(of: item) else { return }
        items.remove(at: index)
        saveToPersistentStorage()
    }
    
    func toggleCheck(of item: ListItem) {
        item.checked = !item.checked
        saveToPersistentStorage()
    }
    
    // MARK: - Persistence
    
    func loadFromPersistentStorage() {
        let jd = JSONDecoder()
        
        do {
            let data = try Data(contentsOf: fileURL())
            self.items = try jd.decode([ListItem].self, from: data)
        } catch let error {
            print(error)
        }
    }
    
    func saveToPersistentStorage() {
        let je = JSONEncoder()
        
        do {
            let data = try je.encode(items)
            try data.write(to: fileURL())
        } catch let error {
            print(error)
        }
    }
    
    private func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectoryURL = urls[0].appendingPathComponent("ShoppingList.json")
        return documentsDirectoryURL
    }
    
}
