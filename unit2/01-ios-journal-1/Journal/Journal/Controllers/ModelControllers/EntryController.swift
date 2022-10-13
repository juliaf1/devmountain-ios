//
//  EntryController.swift
//  Journal
//
//  Created by Julia Frederico on 13/10/22.
//

import Foundation

class EntryController {
    static let shared = EntryController()
    
    var entries: [Entry] = []
    
    // Functions
    
    func create(entryWithTitle title: String, text: String) -> Entry {
        let newEntry = Entry(title: title, text: text)
        self.entries.append(newEntry)
        return newEntry
    }
    
    func delete(entry: Entry) {
        guard let index = entries.firstIndex(where: { $0 == entry }) else { return }
        entries.remove(at: index)
    }
}
