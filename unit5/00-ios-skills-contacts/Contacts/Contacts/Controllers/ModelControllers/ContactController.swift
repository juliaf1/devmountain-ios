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
        
    }
    
    func createContact(name: String, phone: String?, email: String?, photo: UIImage?, completion: @escaping (Error?) -> Void) {
        
    }
    
    func delete(_ contact: Contact, completion: @escaping (Error?) -> Void) {
        
    }
    
    func update(_ contact: Contact, name: String, phone: String?, email: String?, photo: UIImage?, completion: @escaping (Error?) -> Void) {
        
    }
    
    
}
