//
//  PokemonController.swift
//  Pokedex
//
//  Created by Julia Frederico on 11/11/22.
//

import UIKit

class PokemonController {

    // MARK: - Properties
    
    static let baseURL = URL(string: "https://pokeapi.co/api/v2/")
    static let pokemonEP = "pokemon"
    
    // MARK: - URL Session
    
    // Every fetch will either SUCCEED or FAIL, returning a success/error result:
    // Result<Pokemon, Error> // or PokemonError for a custom Error
    
    static func fetchPokemon(searchTerm: String, completion: @escaping (Result<Pokemon, PokemonError>) -> Void) {
        
        // @escaping - gives completion handler permission to run after call to internet is complete

        // 1. URL
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL)) }
        let pokemonURL = baseURL.appendingPathComponent(pokemonEP)
        let finalURL = pokemonURL.appendingPathComponent(searchTerm.lowercased())

        print(finalURL)
        
        // 2. URL Session Data Task
        URLSession.shared.dataTask(with: finalURL) { data, _, error in

            // 3. Error Handling
            if let error = error {
                print("Error fetching from Pokemon API:", error, error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
            
            // 4. Data Unwrap
            guard let data = data else { return completion(.failure(.noData)) }
            
            // 5. Data Decode
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                return completion(.success(pokemon))
            } catch {
                print("Error deconding Pokemon data:", error, error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }

        }.resume()
        
    }
    
    static func fetchSprite(pokemon: Pokemon, completion: @escaping (Result<UIImage, PokemonError>) -> Void) {
        
        // 1 - URL
        let spriteURL = pokemon.sprites.classicSpriteURL
        
        // 2 - Data Task
        URLSession.shared.dataTask(with: spriteURL) { data, _, error in

            // 3 - Error Handling
            if let error = error {
                print("Error fetching sprite:", error, error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
            
            // 4 - Data Unwrap
            guard let data = data else { return completion(.failure(.noData)) }
            
            // 5 - Data Decode
            guard let sprite = UIImage(data: data) else { return completion(.failure(.imageDecodeError)) }
            
            return completion(.success(sprite))
        }.resume()

    }

}
