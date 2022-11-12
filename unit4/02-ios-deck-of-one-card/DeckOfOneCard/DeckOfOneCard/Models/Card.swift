//
//  Card.swift
//  DeckOfOneCard
//
//  Created by Julia Frederico on 12/11/22.
//

import Foundation

struct Card: Decodable {

    let data: CardData

    struct CardData: Decodable {
        let imageURL: URL
        let value: String
        let suit: String
    }
    
    enum CodingKeys: String, CodingKey {
        case data = "cards"
    }

}
