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

    var score = 0
    var gameLevel = GameLevel.beginner
    var gameCards = [Card]()
    var selectedIndexes = [Int]()

    var cards: [Card] {
        let shuffledCards = CardController.countryCards.shuffled().prefix(gameLevel.pairs)
        return Array(shuffledCards)
    }

    @IBOutlet weak var scoreBarButtonItem: UIBarButtonItem!

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
        return gameCards.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as? CardCollectionViewCell else { return UICollectionViewCell() }
        
        let card = gameCards[indexPath.row]

        if selectedIndexes.contains(indexPath.row) {
            cell.displayCard(card)
        } else {
            cell.hideCard(card)
        }
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        // If there are 2 cards selected OR card was already selected, don't allow selection
        if selectedIndexes.firstIndex(of: indexPath.row) != nil || selectedIndexes.count >= 2 { return false }

        // If there are 0 or 1 cards selected, add card index to array and reload data
        selectedIndexes.append(indexPath.row)
        collectionView.reloadData()
        
        if self.selectedIndexes.count == 2 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { // in seconds
                // If there are 2 cards selected and they match
                // remove cards from gameCards, reset selected indexes and increase score
                if self.selectedCardsMatch() {
                    let maxIndex = self.selectedIndexes.max()!
                    let minIndex = self.selectedIndexes.min()!
                    self.gameCards.remove(at: maxIndex)
                    self.gameCards.remove(at: minIndex)
                    self.score += 2
                    self.updateScore()
                    self.collectionView.deleteItems(at: [IndexPath(row: maxIndex, section: 0), IndexPath(row: minIndex, section: 0)])
                }

                // Reset selected indexes and reload data
                self.selectedIndexes = []
                collectionView.reloadData()
            }
        }

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
    
    func updateScore() {
        scoreBarButtonItem.title = "Score: \(score)"
    }
    
    func selectedCardsMatch() -> Bool {
        guard selectedIndexes.count == 2 else { return false }
        return gameCards[selectedIndexes[0]] == gameCards[selectedIndexes[1]]
    }

}

extension CardsCollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width / 2
        return CGSize(width: width - 18, height: width - 18)
    }

}
