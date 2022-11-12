//
//  PokemonTypeController.swift
//  Pokedex
//
//  Created by Julia Frederico on 12/11/22.
//

import Foundation

class PokemonTypeController {
    
    // MARK: - Methods
    
    static func pokemonTypesURL() -> URL? {
        guard let baseURL = URL(string: Strings.baseURL) else { return nil }
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
    
}
