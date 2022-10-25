//
//  CardsCollectionViewController.swift
//  MemoryGame
//
//  Created by Julia Frederico on 25/10/22.
//

import UIKit

enum GameLevel {
    case beginner
    case intermediate
    case advanced
    case master
    
    var pairs: Int {
        switch self {
        case .beginner: return 5
        case .intermediate: return 10
        case .advanced: return 15
        case .master: return 30
        }
    }
}

class CardsCollectionViewController: UICollectionViewController {

    // MARK: - Properties and Outlets

    var gameLevel = GameLevel.beginner
    var gameCards = [Card]()
    var selectedIndexes = [Int]()

    var cards: [Card] {
        let shuffledCards = CardController.countryCards.shuffled().prefix(gameLevel.pairs)
        return Array(shuffledCards)
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        reloadGame()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameLevel.pairs * 2
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath)
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // MARK: - Helpers
    
    func shuffleGameCards() {
        // Assign gameCards to the result of the cards computed property (which returns a shuffled Cards array)
        gameCards = cards
        // Duplicate items in the gameCards array and shuffle their order
        gameCards = Array([gameCards, gameCards].joined()).shuffled()
    }
    
    func reloadGame() {
        selectedIndexes = [] // Reset selected indexes to empty array
        shuffleGameCards() // Shuffle cards
        collectionView.reloadData() // Reload data
    }

}

extension CardsCollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width / 2
        return CGSize(width: width - 18, height: width - 18)
    }

}
