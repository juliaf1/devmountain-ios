//
//  JournalController.swift
//  JournalCD
//
//  Created by Julia Frederico on 27/10/22.
//

import CoreData

class JournalController {
    
    // MARK: - Properties

    static let shared = JournalController()
    
    private init() {
        fetchJournals()
    }
    
    private lazy var fetchRequest: NSFetchRequest<Journal> = {
        let request = NSFetchRequest<Journal>(entityName: Strings.journalEntityName)
        request.predicate = NSPredicate(value: true)
        return request
    }()

    var journals: [Journal] = []
    
    // MARK: - CRUD
    
    func fetchJournals() {
        journals = (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
    }

    func create(title: String) {
        let journal = Journal(title: title)
        journals.append(journal)
        CoreDataStack.saveContext()
    }

    func delete(_ journal: Journal) {
        guard let index = journals.firstIndex(of: journal) else { return }
        journals.remove(at: index)

        CoreDataStack.context.delete(journal)
        CoreDataStack.saveContext()
    }
    
}
