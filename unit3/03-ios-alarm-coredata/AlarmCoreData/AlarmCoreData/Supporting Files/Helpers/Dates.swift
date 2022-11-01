//
//  Dates.swift
//  AlarmCoreData
//
//  Created by Julia Frederico on 01/11/22.
//

import Foundation

extension Date {
    
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter .timeStyle = .medium
        return formatter.string(from: self)
    }
    
}
