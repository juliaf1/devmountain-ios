//
//  Post.swift
//  Continuum
//
//  Created by Julia Frederico on 23/11/22.
//

import UIKit
import CloudKit

struct PostKeys {
    
    static let recordType = "Post"
    static let recordID = "recordID"
    fileprivate static let timestamp = "timestamp"
    fileprivate static let caption = "caption"
    fileprivate static let photoAsset = "photoAsset"
    static let commentsCount = "commentsCount"
    fileprivate static let likesCount = "likesCount"
    
}

class Post {

    // MARK: - Stored Properties

    let timestamp: Date
    let caption: String
    var comments: [Comment]
    var commentsCount: Int
    var likesCount: Int
    let recordID: CKRecord.ID
    
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
    
    init(photo: UIImage, caption: String, comments: [Comment] = [], timestamp: Date = Date(), commentsCount: Int = 0, likesCount: Int = 0, recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.caption = caption
        self.comments = comments
        self.timestamp = timestamp
        self.recordID = recordID
        self.commentsCount = commentsCount
        self.likesCount = likesCount
        self.photo = photo
    }

    convenience init?(ckRecord: CKRecord) {
        guard let timestamp = ckRecord[PostKeys.timestamp] as? Date,
              let caption = ckRecord[PostKeys.caption] as? String,
              let photoAsset = ckRecord[PostKeys.photoAsset] as? CKAsset,
              let commentsCount = ckRecord[PostKeys.commentsCount] as? Int,
              let likesCount = ckRecord[PostKeys.likesCount] as? Int else { return nil }
        
        do {
            let data = try Data(contentsOf: photoAsset.fileURL!)
            guard let photo = UIImage(data: data) else { return nil }
            self.init(photo: photo, caption: caption, timestamp: timestamp, commentsCount: commentsCount, likesCount: likesCount, recordID: ckRecord.recordID)
        } catch {
            return nil
        }
        
    }
    
}

extension Post: SearchableRecord {
    
    func matches(searchTerm: String) -> Bool {
        return self.caption.lowercased().contains(searchTerm.lowercased())
    }
    
}

extension CKRecord {
 
    convenience init(post: Post) {
        self.init(recordType: PostKeys.recordType)
        
        self.setValuesForKeys([
            PostKeys.timestamp: post.timestamp,
            PostKeys.caption: post.caption,
            PostKeys.commentsCount: post.commentsCount,
            PostKeys.likesCount: post.likesCount,
        ])
        
        if let photoAsset = post.photoAsset {
            self.setValue(photoAsset, forKey: PostKeys.photoAsset)
        }
    }
    
    func update(post: Post) {
        guard self.recordType == PostKeys.recordType else { return }
        
        self.setValuesForKeys([
            PostKeys.timestamp: post.timestamp,
            PostKeys.caption: post.caption,
            PostKeys.commentsCount: post.commentsCount,
            PostKeys.likesCount: post.likesCount,
        ])

        if let photoAsset = post.photoAsset {
            self.setValue(photoAsset, forKey: PostKeys.photoAsset)
        }
    }
    
}
