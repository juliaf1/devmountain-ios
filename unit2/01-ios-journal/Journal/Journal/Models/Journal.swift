//
//  Journal.swift
//  Journal
//
//  Created by Julia Frederico on 14/10/22.
//

import Foundation

class Journal: Codable {

    var title: String?
    var entries: [Entry] = []
    
    init(title: String) {
        self.title = title
    }

    init(title: String, entries: [Entry]) {
        self.title = title
        self.entries = entries
    }
}

extension Journal: Equatable {
    static func ==(lhs: Journal, rhs: Journal) -> Bool {
        return lhs.title == rhs.title
    }
}
