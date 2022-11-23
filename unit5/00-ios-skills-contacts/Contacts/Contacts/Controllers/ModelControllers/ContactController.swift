//
//  ContactController.swift
//  Contacts
//
//  Created by Julia Frederico on 23/11/22.
//

import CloudKit
import UIKit

class ContactController {
    
    // MARK: - Properties
    
    static let shared = ContactController()
    
    var contacts: [Contact] = []
    
    let privateDB = CKContainer.default().privateCloudDatabase
    
    // MARK: - Initializers
    
    private init() {}
    
    // MARK: - Helpers Methods
    
    func fetchContacts(completion: @escaping (ContactError?) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: ContactKeys.recordType, predicate: predicate)
        
        privateDB.fetch(withQuery: query) { result in
            switch result {
            case .success(let successResult):
                successResult.matchResults.forEach { matchTuple in
                    if case .success(let record) = matchTuple.1 {
                        guard let contact = Contact(ckRecord: record) else { return }
                        self.contacts.append(contact)
                    }
                }

                return completion(nil)
            case .failure(let error):
                return completion(.thrownError(error))
            }
        }
    }
    
    func createContact(name: String, phone: String?, email: String?, photo: UIImage?, completion: @escaping (ContactError?) -> Void) {
        let contact = Contact(name: name, phone: phone, email: email, photo: photo)
        let record = CKRecord(contact: contact)
        
        privateDB.save(record) { record, error in
            if let error = error {
                return completion(.thrownError(error))
            }
            
            if let record = record {
                guard let contact = Contact(ckRecord: record) else { return completion(.saveError) }
                self.contacts.append(contact)
                return completion(nil)
            }
        }
    }
    
    func delete(_ contact: Contact, completion: @escaping (ContactError?) -> Void) {
        guard let index = contacts.firstIndex(of: contact) else { return completion(.notFoundError) }
        
        let operation = CKModifyRecordsOperation(recordsToSave: nil, recordIDsToDelete: [contact.recordID])
        operation.savePolicy = .changedKeys
        operation.qualityOfService = .userInteractive
        
        operation.modifyRecordsResultBlock = { result in
            switch result {
            case .success:
                self.contacts.remove(at: index)
                return completion(nil)
            case .failure(let error):
                return completion(.thrownError(error))
            }
        }
        
        privateDB.add(operation)
    }
    
    func update(_ contact: Contact, name: String, phone: String?, email: String?, photo: UIImage?, completion: @escaping (ContactError?) -> Void) {
        contact.name = name
        contact.phone = phone
        contact.email = email
        contact.photo = photo
        
        let record = CKRecord(contact: contact) // creates a new ck record with a new record id? how does CK know its the same record that needs to update?
        
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
    
    
}
