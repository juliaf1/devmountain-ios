//
//  DateExtension.swift
//  EventManager
//
//  Created by Julia Frederico on 09/11/22.
//

import Foundation

extension Date {

    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter .timeStyle = .short
        return formatter.string(from: self)
    }

}
