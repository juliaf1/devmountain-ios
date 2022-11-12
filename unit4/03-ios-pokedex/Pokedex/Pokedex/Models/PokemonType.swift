//
//  PokemonType.swift
//  Pokedex
//
//  Created by Julia Frederico on 12/11/22.
//

import Foundation

struct PokemonTypeResponse: Decodable {

    enum CodingKeys: String, CodingKey {
        case types = "results"
    }

    let types: [PokemonType]

    struct PokemonType: Decodable {
        let name: String
        let url: URL
    }

}

struct PokemonTypeDetailResponse: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case pokemonList = "pokemon"
    }

    let pokemonList: [PokemonInfo]
    
    struct PokemonInfo: Decodable {

        enum CodingKeys: String, CodingKey {
            case data = "pokemon"
        }

        let data: Data

        struct Data: Decodable {
            let name: String
            let url: URL
        }
    }

}
