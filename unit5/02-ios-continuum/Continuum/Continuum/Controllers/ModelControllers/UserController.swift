//
//  UserController.swift
//  Continuum
//
//  Created by Julia Frederico on 30/11/22.
//

import Foundation
import CloudKit

class UserController {
    
    // MARK: - Methods
    
    static func fetchAppleUserReference(completion: @escaping (CKRecord.Reference?) -> Void) {

        CKContainer.default().fetchUserRecordID { recordID, error in
            if let error = error {
                print("Error in \(#function): \(error.localizedDescription)")
                return completion(nil)
            }
            
            guard let recordID = recordID else {
                return completion(nil)
            }
            
            let reference = CKRecord.Reference(recordID: recordID, action: .deleteSelf)
            completion(reference)
        }

    }
    
    
}
