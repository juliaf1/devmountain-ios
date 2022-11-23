//
//  Comment.swift
//  Continuum
//
//  Created by Julia Frederico on 23/11/22.
//

import Foundation

class Comment {
    
    // MARK: - Properties
    
    let text: String
    let timestamp: Date
    
    // MARK: - Initializer
    
    init(text: String, timestamp: Date = Date()) {
        self.text = text
        self.timestamp = timestamp
    }
    
}
