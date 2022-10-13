//
//  ModelPlaceholder.swift
//  Journal
//
//  Created by Julia Frederico on 13/10/22.
//

import Foundation

class Entry {
    var title: String
    var text: String
    var timestamp: Date = Date()
    
    init(title: String, text: String) {
        self.title = title
        self.text = text
    }
}
