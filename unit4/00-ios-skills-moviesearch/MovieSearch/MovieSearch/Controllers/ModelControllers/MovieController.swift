//
//  MovieController.swift
//  MovieSearch
//
//  Created by Julia Frederico on 17/11/22.
//

import Foundation

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

    static func fetchSearchResults(searchTerm: String, completion: @escaping () -> Void) {
        
    }
    
}
