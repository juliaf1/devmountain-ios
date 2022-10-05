//
//  Book.swift
//  BookPicks
//
//  Created by Julia Frederico on 05/10/22.
//

import Foundation

class Book {
    let title: String
    let author: String
    let description: String
    let releaseDate: Date
    let photo: String
    var rating: Int
    
    var formattedDate: String {
        return formatDate(fromDate: releaseDate)
    }

    init(title: String, author: String, description: String, releaseDate: Date, photo: String, rating: Int) {
        self.title = title
        self.author = author
        self.description = description
        self.releaseDate = releaseDate
        self.photo = photo
        if rating >= 5 { self.rating = 5 } else { self.rating = rating }
    }
    
    convenience init(title: String, author: String, description: String, stringDate: String, photo: String, rating: Int) {
        let date = formatDate(fromString: stringDate)
        self.init(title: title, author: author, description: description, releaseDate: date, photo: photo, rating: rating)
    }
}

func formatDate(fromString dateString: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyy"
    guard let date = dateFormatter.date(from: dateString) else { return Date() }
    return date
}

func formatDate(fromDate date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyy"
    return dateFormatter.string(from: date)
}
