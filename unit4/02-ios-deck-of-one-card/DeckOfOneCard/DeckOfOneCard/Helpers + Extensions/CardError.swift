//
//  CardError.swift
//  DeckOfOneCard
//
//  Created by Julia Frederico on 12/11/22.
//

import Foundation

enum CardError: LocalizedError {
    
    case invalidURL
    case noData
    case imageDecodeError
    case thrownError(Error)
    
    var description: String {
        switch self {
        case .invalidURL:
            return "Ops, we're having problems reaching the server."
        case .noData:
            return "Sorry, the server has lost his words and failed to send a response with data."
        case .imageDecodeError:
            return "Sorry, we couldn't find the card's image."
        case .thrownError(let error):
            return error.localizedDescription
        }
    }
    
}
