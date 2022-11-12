//
//  PokemonError.swift
//  Pokedex
//
//  Created by Julia Frederico on 11/11/22.
//

import Foundation

enum PokemonError: LocalizedError {
    
    case invalidURL
    case thrownError(Error)
    case noData
    case imageDecodeError
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Unable to reach PokeAPI.co"
        case .thrownError(let error):
            return error.localizedDescription
        case .noData:
            return "Ops, looks like PokeAPI.co couldn't find any data."
        case .imageDecodeError:
            return "Ops, looks like we a have a problem. Try again later, Ash is fixing the server."
        }
    }
    
}
