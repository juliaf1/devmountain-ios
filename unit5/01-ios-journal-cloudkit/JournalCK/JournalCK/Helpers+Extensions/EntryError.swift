//
//  EntryError.swift
//  JournalCK
//
//  Created by Julia Frederico on 22/11/22.
//

import Foundation

enum EntryError: LocalizedError {
    
    case saveError
    case notFoundError
    case thrownError(Error)
    
    var description: String {
        switch self {
        case .saveError:
            return "Ops, there was a problem saving the record."
        case .notFoundError:
            return "Ops, there was a problem finding the record."
        case .thrownError(let error):
            return error.localizedDescription
        }
    }

}
