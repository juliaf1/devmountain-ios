//
//  EntryController.swift
//  Journal
//
//  Created by Julia Frederico on 13/10/22.
//

import Foundation

class EntryController {
    
    // MARK: - Properties
    
    static let shared = EntryController()
    
    var entries: [Entry] = []
    
    // MARK: - Functions
    
    func create(entryWithTitle title: String, text: String) -> Entry {
        let newEntry = Entry(title: title, text: text)
        self.entries.append(newEntry)
        saveToPersistentStorage()

        return newEntry
    }
    
    func delete(entry: Entry) {
        guard let index = entries.firstIndex(where: { $0 == entry }) else { return }
        entries.remove(at: index)
        saveToPersistentStorage()
    }
    
    func loadFromPersistentStorage() {
        let jd = JSONDecoder()
        
        do {
            let data = try Data(contentsOf: fileURL())
            self.entries = try jd.decode([Entry].self, from: data)
        } catch let error {
            print(error)
        }
    }
    
    private func saveToPersistentStorage() {
        let je = JSONEncoder()
        
        do {
            let data = try je.encode(entries)
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
