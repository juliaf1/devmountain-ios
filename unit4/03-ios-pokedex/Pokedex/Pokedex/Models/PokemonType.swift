//
//  PokemonType.swift
//  Pokedex
//
//  Created by Julia Frederico on 12/11/22.
//

import Foundation

struct PokemonTypeResponse: Decodable {
    
    let types: [PokemonType]

    enum CodingKeys: String, CodingKey {
        case types = "results"
    }

}

struct PokemonType: Decodable {
    
    let name: String
    let url: URL

}
