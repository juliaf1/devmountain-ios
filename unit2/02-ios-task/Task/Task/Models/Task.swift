//
//  Task.swift
//  Task
//
//  Created by Julia Frederico on 24/10/22.
//

import Foundation

class Task: Codable {

    var title: String
    var notes: String?
    var deadline: Date?
    var completed: Bool = false

    init(title: String, notes: String? = nil, deadline: Date? = nil) {
        self.title = title
        self.notes = notes
        self.deadline = deadline
    }

}

extension Task: Equatable {
    
    static func ==(rhs: Task, lhs: Task) -> Bool {
        return rhs.title == lhs.title && rhs.deadline == lhs.deadline
    }

}
