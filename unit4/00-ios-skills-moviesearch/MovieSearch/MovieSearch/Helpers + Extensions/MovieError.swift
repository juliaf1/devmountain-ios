//
//  MovieError.swift
//  MovieSearch
//
//  Created by Julia Frederico on 17/11/22.
//

import Foundation

enum MovieError: LocalizedError {

    case invalidURL
    case noData
    case invalidImage
    case thrownError(Error)
    
    var description: String {
        switch self {
        case .invalidURL:
            return "Ops, there was a problem reaching the server."
        case .noData:
            return "Ops, server responded with no data."
        case .invalidImage:
            return "Ops, couldn't decode image."
        case .thrownError(let error):
            return error.localizedDescription
        }
    }

}
