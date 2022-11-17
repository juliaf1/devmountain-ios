//
//  MovieController.swift
//  MovieSearch
//
//  Created by Julia Frederico on 17/11/22.
//

import UIKit

class MovieController {
    
    // MARK: - Properties

    static let baseURL = URL(string: Strings.apiBaseURL)
    
    // MARK: - Methods
    
    static func searchURL(for searchTerm: String) -> URL? {
        guard let baseURL = baseURL else { return nil }

        let searchURL = baseURL.appendingPathComponent(Strings.searchEndpoint).appendingPathComponent(Strings.movieEndpoint)
        var components = URLComponents(url: searchURL, resolvingAgainstBaseURL: true)

        let queryItems = [
            URLQueryItem(name: "api_key", value: Strings.apiKey),
            URLQueryItem(name: "query", value: searchTerm)
        ]
        
        components?.queryItems = queryItems
        
        guard let finalURL = components?.url else { return nil }
        
        return finalURL
    }
    
    static func movieURL(for id: Int) -> URL? {
        guard let baseURL = baseURL else { return nil }

        let movieURL = baseURL.appendingPathComponent(Strings.movieEndpoint).appendingPathComponent("\(id)")
        var components = URLComponents(url: movieURL, resolvingAgainstBaseURL: true)
        
        let queryItems = [URLQueryItem(name: "api_key", value: Strings.apiKey)]
        components?.queryItems = queryItems
        
        guard let finalURL = components?.url else { return nil }
        
        return finalURL
    }

    static func fetchSearchResults(searchTerm: String, completion: @escaping (Result<[Movie], MovieError>) -> Void) {
        guard let url = searchURL(for: searchTerm) else {
            return completion(.failure(.invalidURL))
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                let statusCode = response.statusCode
                if statusCode != 200 {
                    print("STATUS CODE for \(#function): \(statusCode)")
                }
            }
            
            guard let data = data else {
                return completion(.failure(.noData))
            }
            
            do {
                let movieSearchResponse = try JSONDecoder().decode(MovieSearchResponse.self, from: data)
                return completion(.success(movieSearchResponse.results))
            } catch {
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    static func fetchImage(for url: URL, completion: @escaping (Result<UIImage, MovieError>) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                let statusCode = response.statusCode
                if statusCode != 200 {
                    print("STATUS CODE for \(#function): \(statusCode)")
                }
            }
            
            guard let data = data else {
                return completion(.failure(.noData))
            }
            
            guard let image = UIImage(data: data) else {
                return completion(.failure(.invalidImage))
            }
            
            return completion(.success(image))
        }.resume()
        
    }
    
}
