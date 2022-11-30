//
//  PostError.swift
//  Continuum
//
//  Created by Julia Frederico on 23/11/22.
//

import Foundation

enum PostError: LocalizedError {
    
    case thrownError(Error)
    case recordError
    
    var description: String {
        switch self {
        case .thrownError(let error):
            return error.localizedDescription
        case .recordError:
            return "There was an error handling your database records."
        }
    }
    
}
