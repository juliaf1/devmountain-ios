//
//  EntryController.swift
//  Journal
//
//  Created by Julia Frederico on 14/10/22.
//

import Foundation

class EntryController {

    // MARK: - Methods
    
    static func create(entryWithTitle title: String, text: String, journal: Journal) -> Entry {
        let entry = Entry(title: title, text: text)
        JournalController.shared.addEntryTo(journal: journal, entry: entry)
        return entry
    }
    
    static func delete(entry: Entry, journal: Journal) {
        JournalController.shared.removeEntryFrom(journal: journal, entry: entry)
    }

    static func update(entry: Entry, title: String, text: String) -> Entry {
        entry.title = title
        entry.text = text
        JournalController.shared.saveToPersistentStorage()
        return entry
    }

}
