//
//  ContactError.swift
//  Contacts
//
//  Created by Julia Frederico on 23/11/22.
//

import Foundation

enum ContactError: LocalizedError {
    
    case saveError
    case notFoundError
    case missingRequiredParam(String)
    case thrownError(Error)
    
    var description: String {
        switch self {
        case .saveError:
            return "Ops, there was a problem saving the record."
        case .notFoundError:
            return "Ops, we couldn't find the record."
        case .missingRequiredParam(let param):
            return "Please, fill in the \(param)."
        case .thrownError(let error):
            return error.localizedDescription
        }
    }
    
}
