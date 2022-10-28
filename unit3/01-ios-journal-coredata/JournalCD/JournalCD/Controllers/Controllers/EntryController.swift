//
//  EntryController.swift
//  JournalCD
//
//  Created by Julia Frederico on 27/10/22.
//

import Foundation

class EntryController {

    static func addEntry(to journal: Journal, withTitle title: String, text: String) {
        Entry(title: title, text: text, journal: journal)
        CoreDataStack.saveContext()
    }
    
    static func update(entry: Entry, withTitle title: String, text: String) {
        entry.title = title
        entry.text = text
        entry.timestamp = Date()
        CoreDataStack.saveContext()
    }

    static func remove(entry: Entry) {
        CoreDataStack.context.delete(entry)
        CoreDataStack.saveContext()
    }

}
