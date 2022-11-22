//
//  Entry.swift
//  JournalCK
//
//  Created by Julia Frederico on 22/11/22.
//

import CloudKit

struct EntryKeys {
    static let recordType = "Entry"
    fileprivate static let title = "title"
    fileprivate static let detail = "detail"
    fileprivate static let timestamp = "timestamp"
    fileprivate static let recordID = "recordID"
}

class Entry {
    
    // MARK: - Properties
    
    var title: String
    var detail: String
    var timestamp: Date
    var recordID: CKRecord.ID
    
    // MARK: - Initializers
    
    init(title: String, detail: String, timestamp: Date = Date(), recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.title = title
        self.detail = detail
        self.timestamp = timestamp
        self.recordID = recordID
    }
    
    convenience init?(ckRecord: CKRecord) {
        guard let title = ckRecord[EntryKeys.title] as? String,
              let detail = ckRecord[EntryKeys.detail] as? String,
              let timestamp = ckRecord[EntryKeys.timestamp] as? Date else { return nil }
        
        self.init(title: title, detail: detail, timestamp: timestamp, recordID: ckRecord.recordID)
    }

}

extension Entry: Equatable {
    
    static func ==(lhs: Entry, rhs: Entry) -> Bool {
        return lhs.recordID == rhs.recordID
    }
    
}

extension CKRecord {
    
    convenience init(entry: Entry) {
        self.init(recordType: EntryKeys.recordType)

        self.setValuesForKeys([
            EntryKeys.title: entry.title,
            EntryKeys.detail: entry.detail,
            EntryKeys.timestamp: entry.timestamp
        ])
        
    }
    
}
