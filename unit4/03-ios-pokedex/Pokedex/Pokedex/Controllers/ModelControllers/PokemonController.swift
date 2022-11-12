//
//  PokemonController.swift
//  Pokedex
//
//  Created by Julia Frederico on 11/11/22.
//

import UIKit

class PokemonController {

    // MARK: - Properties
    
    static let baseURL = URL(string: Strings.baseURL)
    static let pokemonEP = Strings.pokemonEndpoint
    
    // MARK: - URL Session
    
    static func pokemonURL(for searchTerm: String) -> URL? {
        guard let baseURL = baseURL else { return nil }
        
        let pokemonURL = baseURL.appendingPathComponent(pokemonEP).appendingPathComponent(searchTerm)
    
        return pokemonURL
    }
    
    static func fetchPokemon(searchTerm: String, completion: @escaping (Result<Pokemon, PokemonError>) -> Void) {

        // 1. URL
        guard let pokemonURL = pokemonURL(for: searchTerm) else { return completion(.failure(.invalidURL)) }
        
        // 2. URL Session Data Task
        URLSession.shared.dataTask(with: pokemonURL) { data, _, error in

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
    
    static func fetchPokemons(of type: PokemonType, completion: @escaping (Result<[Pokemon], PokemonError>) -> Void) {
        
        URLSession.shared.dataTask(with: type.url) { data, response, error in
            
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                let status = response.statusCode
                if status != 200 {
                    print("STATUS CODE in \(#function): \(status)")
                }
            }
            
            guard let data = data else {
                return completion(.failure(.noData))
            }
            
            do {
                let pokemonTypeDetailResponse = try JSONDecoder().decode(PokemonTypeDetailResponse.self, from: data)
                
                let pokemonsInfo = pokemonTypeDetailResponse.pokemonList
                
                var pokemons: [Pokemon] = []
                
                for pokemonInfo in pokemonsInfo {
                    fetchPokemon(url: pokemonInfo.data.url) { result in
                        switch result {
                        case .success(let pokemon):
                            pokemons.append(pokemon)
                        case .failure:
                            break
                        }
                    }
                }
                
                print("poke list", pokemons) // BUG: its not waiting for pokemon loop to finish
                return completion(.success(pokemons))
            } catch {
                return completion(.failure(.thrownError(error)))
            }
            
        }.resume()
        
    }
    
    static func fetchPokemon(url: URL, completion: @escaping (Result<Pokemon, PokemonError>) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                let status = response.statusCode
                if status != 200 {
                    print("STATUS CODE in \(#function): \(status)")
                }
            }
            
            guard let data = data else {
                return completion(.failure(.noData))
            }
            
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                return completion(.success(pokemon))
            } catch {
                return completion(.failure(.thrownError(error)))
            }
            
        }.resume()
        
    }

}
