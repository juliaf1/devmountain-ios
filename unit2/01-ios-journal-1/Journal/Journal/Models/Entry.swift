//
//  ModelPlaceholder.swift
//  Journal
//
//  Created by Julia Frederico on 13/10/22.
//

import Foundation

class Entry: Codable {
    var title: String
    var text: String
    var timestamp: Date = Date()
    
    init(title: String, text: String) {
        self.title = title
        self.text = text
    }
}

extension Entry: Equatable {
    static func ==(lhs: Entry, rhs: Entry) -> Bool {
        return lhs.text == rhs.text && lhs.title == rhs.title
    }
}
