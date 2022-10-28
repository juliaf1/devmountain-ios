//
//  Entry+Convenience.swift
//  JournalCD
//
//  Created by Julia Frederico on 27/10/22.
//

import CoreData

extension Entry {
    
    @discardableResult convenience init(title: String, text: String, journal: Journal, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.id = UUID().uuidString
        self.title = title
        self.text = text
        self.journal = journal
        self.timestamp = Date()
    }

    var formattedDate: String {
        DateFormatter.entryTimestamp.string(from: timestamp ?? Date())
    }

}
