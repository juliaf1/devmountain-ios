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
    
    func createEntryWith(title: String, text: String) -> Entry {
        let newEntry = Entry(title: title, text: text)
        self.entries.append(newEntry)
        return newEntry
    }
}
