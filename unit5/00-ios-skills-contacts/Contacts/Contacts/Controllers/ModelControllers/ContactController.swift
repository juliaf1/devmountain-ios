//
//  ContactController.swift
//  Contacts
//
//  Created by Julia Frederico on 23/11/22.
//

import Foundation
import CloudKit

class ContactController {
    
    // MARK: - Properties
    
    static let shared = ContactController()
    
    var contacts: [Contact] = []
    
    let privateDB = CKContainer.default().privateCloudDatabase
    
    // MARK: - Initializers
    
    private init() {}
    
    // MARK: - Helpers Methods
    
    
}
