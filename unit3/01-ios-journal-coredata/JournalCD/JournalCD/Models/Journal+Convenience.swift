//
//  Journal+Convenience.swift
//  JournalCD
//
//  Created by Julia Frederico on 27/10/22.
//

import CoreData

extension Journal {
    
    @discardableResult convenience init(title: String, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.id = UUID().uuidString
        self.title = title
    }

    var mutableEntries: [Entry] {
        guard let entries = self.mutableArrayValue(forKey: Strings.entriesKey) as? Array<Entry> else { return [] }
        return entries
    }

}
