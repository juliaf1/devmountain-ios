//
//  Dates.swift
//  JournalCD
//
//  Created by Julia Frederico on 27/10/22.
//

import Foundation

extension DateFormatter {
    static let entryTimestamp: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        return formatter
    }()
}
