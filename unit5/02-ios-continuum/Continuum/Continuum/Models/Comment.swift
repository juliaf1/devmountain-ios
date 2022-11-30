//
//  Comment.swift
//  Continuum
//
//  Created by Julia Frederico on 23/11/22.
//

import Foundation
import CloudKit

struct CommentKeys {
    
    static let recordType = "Comment"
    static let recordID = "recordID"
    static let postReference = "postReference"
    fileprivate static let text = "text"
    fileprivate static let timestamp = "timestamp"
    
}

class Comment {
    
    // MARK: - Properties
    
    let text: String
    let timestamp: Date
    let recordID: CKRecord.ID
    let postReference: CKRecord.Reference?
    
    // MARK: - Initializer
    
    init(text: String, timestamp: Date = Date(), postReference: CKRecord.Reference, recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.text = text
        self.timestamp = timestamp
        self.postReference = postReference
        self.recordID = recordID
    }
    
    convenience init?(ckRecord: CKRecord) {
        guard let text = ckRecord[CommentKeys.text] as? String,
              let timestamp = ckRecord[CommentKeys.timestamp] as? Date,
              let postReference = ckRecord[CommentKeys.postReference] as? CKRecord.Reference else { return nil }
        
        self.init(text: text, timestamp: timestamp, postReference: postReference, recordID: ckRecord.recordID)
    }
    
}

extension CKRecord {
    
    convenience init(comment: Comment) {
        self.init(recordType: CommentKeys.recordType)
        
        self.setValuesForKeys([
            CommentKeys.text: comment.text,
            CommentKeys.timestamp: comment.timestamp,
            CommentKeys.postReference: comment.postReference!,
        ])
    }
    
}
