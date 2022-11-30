//
//  Like.swift
//  Continuum
//
//  Created by Julia Frederico on 30/11/22.
//

import Foundation
import CloudKit

struct LikeKeys {
    
    static let recordType = "PostLikes"
    static let recordID = "recordID"
    static let postReference = "postReference"
    static let userReference = "userReference"
    
}

class Like {
    
    let recordID: CKRecord.ID
    let postReference: CKRecord.Reference
    let userReference: CKRecord.Reference
    
    init(postReference: CKRecord.Reference, userReference: CKRecord.Reference, recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.postReference = postReference
        self.userReference = userReference
        self.recordID = recordID
    }
    
    convenience init?(ckRecord: CKRecord) {
        guard let postReference = ckRecord[LikeKeys.postReference] as? CKRecord.Reference,
              let userReference = ckRecord[LikeKeys.userReference] as? CKRecord.Reference else { return nil }
        
        self.init(postReference: postReference, userReference: userReference, recordID: ckRecord.recordID)
    }
    
}

extension CKRecord {
    
    convenience init(like: Like) {
        self.init(recordType: LikeKeys.recordType)
        
        self.setValuesForKeys([
            LikeKeys.postReference: like.postReference,
            LikeKeys.userReference: like.userReference,
        ])
    }
    
}
