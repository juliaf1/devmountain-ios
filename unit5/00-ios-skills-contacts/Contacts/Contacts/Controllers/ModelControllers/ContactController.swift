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
    
    func fetchContacts(completion: @escaping (Error?) -> Void) {
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
                return completion(error)
            }
        }
    }
    
    func createContact(name: String, phone: String?, email: String?, photo: UIImage?, completion: @escaping (Error?) -> Void) {
        
    }
    
    func delete(_ contact: Contact, completion: @escaping (Error?) -> Void) {
        
    }
    
    func update(_ contact: Contact, name: String, phone: String?, email: String?, photo: UIImage?, completion: @escaping (Error?) -> Void) {
        
    }
    
    
}
