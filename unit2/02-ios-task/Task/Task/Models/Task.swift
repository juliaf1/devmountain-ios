//
//  Task.swift
//  Task
//
//  Created by Julia Frederico on 24/10/22.
//

import Foundation

class Task: Codable {

    let title: String
    let deadline: Date
    var completed: Bool = false
    
    init(title: String, deadline: Date) {
        self.title = title
        self.deadline = deadline
    }

}

extension Task: Equatable {
    
    static func ==(rhs: Task, lhs: Task) -> Bool {
        return rhs.title == lhs.title && rhs.deadline == lhs.deadline
    }

}
