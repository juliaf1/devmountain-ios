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
    
    func fetchAllEntries(completion: @escaping (EntryError?) -> Void) {
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
                return completion(.thrownError(error))
            }
        }
    }
    
    func createEntry(title: String, detail: String, completion: @escaping (EntryError?) -> Void) {
        let entry = Entry(title: title, detail: detail)
        let record = CKRecord(entry: entry)
        
        privateDB.save(record) { record, error in
            if let error = error {
                return completion(.thrownError(error))
            }
            
            guard let record = record,
                  let savedEntry = Entry(ckRecord: record)
            else {
                return completion(.saveError)
            }
            
            self.entries.append(savedEntry)
            return completion(nil)
        }
    }
    
    func update(_ entry: Entry, title: String, detail: String, completion: @escaping (EntryError?) -> Void) {
        let record = CKRecord(entry: entry)
        let operation = CKModifyRecordsOperation(recordsToSave: [record], recordIDsToDelete: nil)

        operation.savePolicy = .changedKeys
        operation.qualityOfService = .userInteractive

        operation.modifyRecordsResultBlock = { result in
            switch result {
            case .success:
                return completion(nil)
            case .failure(let error):
                return completion(.thrownError(error))
            }
        }
        
        privateDB.add(operation)
    }
    
    func delete(_ entry: Entry, completion: @escaping (EntryError?) -> Void) {
        guard let index = entries.firstIndex(of: entry) else { return completion(.notFoundError) }
        
        let operation = CKModifyRecordsOperation(recordsToSave: nil, recordIDsToDelete: [entry.recordID])
        operation.savePolicy = .changedKeys
        operation.qualityOfService = .userInteractive
        
        operation.modifyRecordsResultBlock = { result in
            switch result {
            case .success:
                self.entries.remove(at: index)
                return completion(nil)
            case .failure(let error):
                return completion(.thrownError(error))
            }
        }
        
        privateDB.add(operation)
    }
    
}
