//
//  Contact.swift
//  Contacts
//
//  Created by Julia Frederico on 22/11/22.
//

import CloudKit
import UIKit

struct ContactKeys {
    
    static let recordType = "Contact"
    fileprivate static let name = "name"
    fileprivate static let phone = "phone"
    fileprivate static let email = "email"
    fileprivate static let photoAsset = "photoAsset"
    
}

class Contact {
    
    var name: String
    var phone: String?
    var email: String?
    var recordID: CKRecord.ID
    
    var photo: UIImage? {
        get {
            guard let photoData = self.photoData else { return nil }
            return UIImage(data: photoData)
        } set {
            self.photoData = newValue?.jpegData(compressionQuality: 0.5)
        }
    }
    
    var photoData: Data?

    var photoAsset: CKAsset? {
        get {
            guard let photoData = photoData else {
                return nil
            }
            
            let tempDirectory = NSTemporaryDirectory()
            let tempDirectoryURL = URL(fileURLWithPath: tempDirectory)
            let fileURL = tempDirectoryURL.appendingPathComponent(UUID().uuidString).appendingPathExtension("jpg")
            
            do {
                try photoData.write(to: fileURL)
            } catch {
                print("Error in \(#function): \(error.localizedDescription)")
            }
            
            return CKAsset(fileURL: fileURL)
        }
    }

    init(name: String, phone: String?, email: String?, photo: UIImage?, recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.name = name
        self.phone = phone
        self.email = email
        self.recordID = recordID
        self.photo = photo
    }
    
    convenience init?(ckRecord: CKRecord) {
        guard let name = ckRecord[ContactKeys.name] as? String else { return nil }
        
        var photo: UIImage?
        if let photoAsset = ckRecord[ContactKeys.photoAsset] as? CKAsset {
            do {
                let data = try Data(contentsOf: photoAsset.fileURL!)
                photo = UIImage(data: data)
            } catch {
                print("Could not transform the asset found to data")
            }
        }
        
        let phone = ckRecord[ContactKeys.phone] as? String
        let email = ckRecord[ContactKeys.email] as? String
        
        self.init(name: name, phone: phone, email: email, photo: photo, recordID: ckRecord.recordID)
    }
    
}
