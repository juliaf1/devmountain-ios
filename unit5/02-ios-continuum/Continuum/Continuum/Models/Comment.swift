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
    fileprivate static let text = "text"
    fileprivate static let timestamp = "timestamp"
    
}

class Comment {
    
    // MARK: - Properties
    
    let text: String
    let timestamp: Date
    let recordID: CKRecord.ID
    
    // MARK: - Initializer
    
    init(text: String, timestamp: Date = Date(), recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.text = text
        self.timestamp = timestamp
        self.recordID = recordID
    }
    
    convenience init?(ckRecord: CKRecord) {
        guard let text = ckRecord[CommentKeys.text] as? String,
              let timestamp = ckRecord[CommentKeys.timestamp] as? Date,
              let recordID = ckRecord[CommentKeys.recordID] as? CKRecord.ID else { return nil }
        
        self.init(text: text, timestamp: timestamp, recordID: recordID)
    }
    
}

extension CKRecord {
    
    convenience init(comment: Comment) {
        self.init(recordType: CommentKeys.recordType)
        
        self.setValuesForKeys([
            CommentKeys.text: comment.text,
            CommentKeys.timestamp: comment.timestamp,
        ])
    }
    
}
