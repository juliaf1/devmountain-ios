//
//  Post.swift
//  Continuum
//
//  Created by Julia Frederico on 23/11/22.
//

import UIKit
import CloudKit

class Post {

    // MARK: - Stored Properties

    let timestamp: Date
    let caption: String
    var comments: [Comment]
    var recordID: CKRecord.ID
    
    var photoData: Data?

    // MARK: - Computed Properties

    var photo: UIImage? {
        get {
            guard let photoData = photoData else {
                return nil
            }
            return UIImage(data: photoData)
        } set {
            self.photoData = newValue?.jpegData(compressionQuality: 0.5)
        }
    }
    
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
    
    // MARK: - Initializer
    
    init(photo: UIImage, caption: String, comments: [Comment] = [], timestamp: Date = Date(), recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.caption = caption
        self.comments = comments
        self.timestamp = timestamp
        self.recordID = recordID
        self.photo = photo
    }
    
}

extension Post: SearchableRecord {
    
    func matches(searchTerm: String) -> Bool {
        return self.caption.lowercased().contains(searchTerm.lowercased())
    }
    
}
