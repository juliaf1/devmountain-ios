//
//  ContactController.swift
//  Contacts
//
//  Created by Julia Frederico on 23/11/22.
//

import CloudKit
import UIKit

let contactsSetNotificationName = Notification.Name("contactsWereSet")

class ContactController {
    
    // MARK: - Properties
    
    static let shared = ContactController()
    
    var contacts: [Contact] = [] {
        didSet {
            if oldValue.count < contacts.count {
                // adding a new contact
                NotificationCenter.default.post(name: contactsSetNotificationName, object: self)
            }
        }
    }
    
    let privateDB = CKContainer.default().privateCloudDatabase
    
    // MARK: - Initializers
    
    private init() {}
    
    // MARK: - Helpers Methods
    
    func fetchContacts(completion: @escaping (ContactError?) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: ContactKeys.recordType, predicate: predicate)
        
        var fetchContacts: [Contact] = []
        
        privateDB.fetch(withQuery: query) { result in
            switch result {
            case .success(let successResult):
                successResult.matchResults.forEach { matchTuple in
                    if case .success(let record) = matchTuple.1 {
                        guard let contact = Contact(ckRecord: record) else { return }
                        fetchContacts.append(contact)
                    }
                }

                self.contacts = fetchContacts
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
            
            guard let record = record,
                  let savedContact = Contact(ckRecord: record) else {
                return completion(.notFoundError)
            }
            
            self.contacts.append(savedContact)
            return completion(nil)
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
    
    func fetchRecord(with recordID: CKRecord.ID) async -> CKRecord? {
        let predicate = NSPredicate(format: "%K == %@", argumentArray: [ContactKeys.recordID, recordID])
        let query = CKQuery(recordType: ContactKeys.recordType, predicate: predicate)
        
        return await withCheckedContinuation { continuation in
            privateDB.fetch(withQuery: query) { result in
                switch result {
                case .success(let successResult):
                    let recordResult = successResult.matchResults.filter { $0.0 == recordID }
                    
                    if case .success(let record) = recordResult.first?.1 {
                        return continuation.resume(returning: record)
                    }
                case .failure:
                    return continuation.resume(returning: nil)
                }
            }
        }
    }
    
    func update(_ contact: Contact, name: String, phone: String?, email: String?, photo: UIImage?, completion: @escaping (ContactError?) -> Void) async {
        let record = await fetchRecord(with: contact.recordID)
        guard let record = record else {
            return completion(.notFoundError)
        }
        
        contact.name = name
        contact.phone = phone
        contact.email = email
        contact.photo = photo
        
        record.updateContactValues(contact: contact)
        
        let operation = CKModifyRecordsOperation(recordsToSave: [record], recordIDsToDelete: nil)
        operation.savePolicy = .changedKeys
        operation.qualityOfService = .userInteractive
        
        operation.modifyRecordsResultBlock = { result in
            switch result {
            case .success:
                NotificationCenter.default.post(name: contactsSetNotificationName, object: self)
                return completion(nil)
            case .failure(let error):
                return completion(.thrownError(error))
            }
        }
        
        self.privateDB.add(operation)
    }

}
