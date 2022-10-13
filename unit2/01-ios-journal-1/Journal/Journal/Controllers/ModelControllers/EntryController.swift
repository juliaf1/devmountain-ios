//
//  EntryController.swift
//  Journal
//
//  Created by Julia Frederico on 13/10/22.
//

import Foundation

class EntryController {
    static let shared = EntryController()
    
    var entries: [Entry]
    
    init() {
        let firstEntry = Entry(title: "My first entry", text: "Start here...")
        self.entries = [firstEntry]
    }
}
