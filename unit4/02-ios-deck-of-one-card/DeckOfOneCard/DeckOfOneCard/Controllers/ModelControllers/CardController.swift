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
    static let drawCardEP = "/deck/new/draw"

    static let drawOneCardURL: URL? = {
        guard let baseURL = baseURL else { return nil }
        
        let drawCardURL = baseURL.appendingPathComponent(drawCardEP)
        var urlComponents = URLComponents(url: drawCardURL, resolvingAgainstBaseURL: true)
        
        let countQuery = URLQueryItem(name: "count", value: "1")
        urlComponents?.queryItems = [countQuery]
        
        guard let finalURL = urlComponents?.url else { return nil }
        
        return finalURL
    }()
    
    // MARK: - Methods
    
    static func fetchOneCard(completion: @escaping (Result<Card, CardError>) -> Void) {
        
        guard let url = drawOneCardURL else { return completion(.failure(.invalidURL)) }
        
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
                let cardResponse = try JSONDecoder().decode(CardResponse.self, from: data)
                guard let card = cardResponse.cards.first else { return completion(.failure(.noData)) }

                return completion(.success(card))
            } catch {
                return completion(.failure(.thrownError(error)))
            }
                    
        }.resume()
        
    }
    
}
