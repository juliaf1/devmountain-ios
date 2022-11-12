//
//  Card.swift
//  DeckOfOneCard
//
//  Created by Julia Frederico on 12/11/22.
//

import Foundation

struct CardResponse: Decodable {
    let cards: [Card]
}

struct Card: Decodable {
    
    let imageURL: URL
    let value: String
    let suit: String

    enum CodingKeys: String, CodingKey {
        case imageURL = "image"
        case value
        case suit
    }

}
