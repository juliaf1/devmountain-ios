//
//  DateExtension.swift
//  JournalCK
//
//  Created by Julia Frederico on 22/11/22.
//

import Foundation

extension Date {
    
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
    
}
