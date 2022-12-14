//
//  Card.swift
//  MemoryGame
//
//  Created by Julia Frederico on 25/10/22.
//

import Foundation

class Card {

    let name: String
    let emoji: String

    init(name: String, emoji: String) {
        self.name = name
        self.emoji = emoji
    }

}

extension Card: Equatable {

    static func ==(rhs: Card, lhs: Card) -> Bool {
        return rhs.name == lhs.name && rhs.emoji == lhs.emoji
    }

}
