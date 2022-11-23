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
    case thrownError(Error)
    
}
