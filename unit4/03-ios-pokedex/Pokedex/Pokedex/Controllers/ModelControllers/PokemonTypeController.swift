//
//  PokemonTypeController.swift
//  Pokedex
//
//  Created by Julia Frederico on 12/11/22.
//

import Foundation

class PokemonTypeController {
    
    // MARK: - Properties
    
    static let baseURL = URL(string: Strings.baseURL)
    
    // MARK: - Methods
    
    static func pokemonTypesURL() -> URL? {
        guard let baseURL = baseURL else { return nil }
        let typeURL = baseURL.appendingPathComponent(Strings.pokemonTypeEndpoint)
        return typeURL
    }

    static func fetchAllPokemonTypes(completion: @escaping (Result<[PokemonType], PokemonError>) -> Void) {
        
        guard let typesURL = pokemonTypesURL() else { return completion(.failure(.invalidURL)) }
        
        URLSession.shared.dataTask(with: typesURL) { data, response, error in
            
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
                let pokemonTypesResponse = try JSONDecoder().decode(PokemonTypeResponse.self, from: data)
                return completion(.success(pokemonTypesResponse.types))
            } catch {
                return completion(.failure(.thrownError(error)))
            }
            
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
                
                for info in pokemonsInfo {
                    fetchPokemon(pokemonInfo: info) { result in
                        switch result {
                        case .success(let pokemon):
                            pokemons.append(pokemon)
                        case .failure:
                            break
                        }
                    }
                }
                
                return completion(.success(pokemons))
            } catch {
                return completion(.failure(.thrownError(error)))
            }
            
        }.resume()
        
    }
    
    static func fetchPokemon(pokemonInfo: PokemonInfo, completion: @escaping (Result<Pokemon, PokemonError>) -> Void) {
        
        URLSession.shared.dataTask(with: pokemonInfo.data.url) { data, response, error in
            
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
