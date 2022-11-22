//
//  EntryController.swift
//  JournalCK
//
//  Created by Julia Frederico on 22/11/22.
//

import CloudKit

class EntryController {
    
    // MARK: - Properties
    
    static let shared = EntryController()
    
    let privateDB = CKContainer.default().privateCloudDatabase
    
    var entries: [Entry] = [] {
        didSet {
            // TODO: send entries were set notification
        }
    }
    
    // MARK: - Initializers
    
    private init() {}
    
    // MARK: - CRUD Methods
    
    func fetchAllEntries(completion: @escaping (Error?) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: EntryKeys.recordType, predicate: predicate)
        
        var entries = [Entry]()
        
        privateDB.fetch(withQuery: query) { result in
            switch result {
            case .success(let sucessResult):
                sucessResult.matchResults.forEach { matchTuple in
                    if case .success(let entryRecord) = matchTuple.1 {
                        guard let entry = Entry(ckRecord: entryRecord) else { return }
                        entries.append(entry)
                    }
                }
                self.entries = entries
                return completion(nil)
            case .failure(let error):
                return completion(error)
            }
        }
    }
    
    func createEntry(title: String, detail: String) {}
    
}
