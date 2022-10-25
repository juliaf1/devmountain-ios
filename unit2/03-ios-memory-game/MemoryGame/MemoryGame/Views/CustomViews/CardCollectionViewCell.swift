//
//  CardCollectionViewCell.swift
//  MemoryGame
//
//  Created by Julia Frederico on 25/10/22.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var cardLabel: UILabel!

    func displayCard(_ card: Card) {
        cardView.backgroundColor = .systemGray4
        cardLabel.text = card.emoji
        cardLabel.font = cardLabel.font.withSize(32)
    }
    
    func hideCard(_ card: Card) {
        cardView.backgroundColor = .systemIndigo
        cardLabel.text = "🙈"
        cardLabel.font = cardLabel.font.withSize(12)
    }

}
