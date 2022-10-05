//
//  Book.swift
//  BookPicks
//
//  Created by Julia Frederico on 05/10/22.
//

import Foundation

class Book {
    let title: String
    let description: String
    let photo: String
    var rating: Int
    
    init(title: String, description: String, photo: String, rating: Int) {
        self.title = title
        self.description = description
        self.photo = photo
        if rating >= 5 { self.rating = 5 } else { self.rating = rating }
    }
}
