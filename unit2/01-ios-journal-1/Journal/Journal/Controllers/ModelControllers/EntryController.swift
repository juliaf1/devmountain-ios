//
//  EntryController.swift
//  Journal
//
//  Created by Julia Frederico on 14/10/22.
//

import Foundation

class EntryController {
    
    // MARK: - Properties
    
    var journalController: JournalController
    
    // MARK: - Inits
    
    init(journalController: JournalController) {
        self.journalController = journalController
    }
    
    // MARK: - Methods
    
    func create(entryWithTitle title: String, text: String, journal: Journal) {
        let entry = Entry(title: title, text: text)
        journalController.addEntryTo(journal: journal, entry: entry)
    }
    
    func delete(entry: Entry, journal: Journal) {
        journalController.removeEntryFrom(journal: journal, entry: entry)
    }
}
