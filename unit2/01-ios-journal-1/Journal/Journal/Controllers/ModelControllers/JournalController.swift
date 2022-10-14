//
//  JournalController.swift
//  Journal
//
//  Created by Julia Frederico on 14/10/22.
//

import Foundation

class JournalController {
    
    // MARK: - Properties & Singleton
    
    static let shared = JournalController()
    
    var journals: [Journal] = []
    
    // MARK: - Methods
    
    func create(journalWithTitle title: String) -> Journal {
        let newJournal = Journal(title: title)
        self.journals.append(newJournal)
        saveToPersistentStorage()

        return newJournal
    }
    
    func delete(journal: Journal) {
        guard let index = journals.firstIndex(where: { $0 == journal }) else { return }
        journals.remove(at: index)
        saveToPersistentStorage()
    }
    
    func addEntryTo(journal: Journal, entry: Entry) {
        guard let index = journals.firstIndex(where: { $0 == journal }) else { return }
        journals[index].entries.append(entry)
        saveToPersistentStorage()
    }
    
    func removeEntryFrom(journal: Journal, entry: Entry) {
        guard let journalIndex = journals.firstIndex(where: { $0 == journal }) else { return }
        let journal = journals[journalIndex]
        guard let entryIndex = journal.entries.firstIndex(of: entry) else { return }
        journal.entries.remove(at: entryIndex)
        saveToPersistentStorage()
    }

    func loadFromPersistentStorage() {
        let jd = JSONDecoder()
        
        do {
            let data = try Data(contentsOf: fileURL())
            self.journals = try jd.decode([Journal].self, from: data)
        } catch let error {
            print(error)
        }
    }
    
    func saveToPersistentStorage() {
        let je = JSONEncoder()
        
        do {
            let data = try je.encode(journals)
            try data.write(to: fileURL())
        } catch let error {
            print(error)
        }
    }
    
    private func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectoryURL = urls[0].appendingPathComponent("Journal.json")
        return documentsDirectoryURL
    }
}
