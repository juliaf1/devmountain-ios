//
//  CardController.swift
//  DeckOfOneCard
//
//  Created by Julia Frederico on 12/11/22.
//

import Foundation

class CardController {
    
    // MARK: - Properties
    
    static let baseURL = URL(string: "https://deckofcardsapi.com/api")
    static let drawCardEP = "/deck/new/draw" // ?count=1

    static var drawOneCardURL: URL? {
        guard let baseURL = baseURL else { return nil }
        
        let drawCardURL = baseURL.appendingPathComponent(drawCardEP)
        var urlComponents = URLComponents(url: drawCardURL, resolvingAgainstBaseURL: true)
        
        let countQuery = URLQueryItem(name: "count", value: "1")
        urlComponents?.queryItems = [countQuery]
        
        guard let finalURL = urlComponents?.url else { return nil }
        
        return finalURL
    }
    
    // MARK: - Methods
    
    static func fetchOneCard(completion: @escaping (Result<Card, Error>) -> Void) {
        
    }
    
}
