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
    
    var formattedDate: String {
        formatDate(fromDate: timestamp)
    }

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

func formatDate(fromDate date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
    return dateFormatter.string(from: date)
}
