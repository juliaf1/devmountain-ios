//
//  EntryError.swift
//  JournalCK
//
//  Created by Julia Frederico on 22/11/22.
//

import Foundation

enum EntryError: LocalizedError {
    
    case saveError
    case thrownError(Error)
    
    func description() -> String {
        switch self {
        case .saveError:
            return "Ops, there was a problem saving the record."
        case .thrownError(let error):
            return error.localizedDescription
        }
    }

}
