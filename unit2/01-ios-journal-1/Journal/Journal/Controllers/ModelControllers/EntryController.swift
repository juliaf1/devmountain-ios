//
//  EntryController.swift
//  Journal
//
//  Created by Julia Frederico on 13/10/22.
//

import Foundation

class EntryController {
    static let shared = EntryController()
    
    var entries: [Entry]
    
    init() {
        let firstEntry = Entry(title: "My first entry", text: "Start here...")
        self.entries = [firstEntry]
    }
    
    // Functions
    
    func create(entryWithTitle title: String, text: String) -> Entry {
        let newEntry = Entry(title: title, text: text)
        self.entries.append(newEntry)
        return newEntry
    }
    
    func delete(entry: Entry) -> Bool {
        guard let index = entries.firstIndex(where: { $0 == entry }) else { return false }
        entries.remove(at: index)
        return true
    }
}
