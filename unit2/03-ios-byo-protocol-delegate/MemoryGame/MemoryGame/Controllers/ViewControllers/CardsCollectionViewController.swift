//
//  CardsCollectionViewController.swift
//  MemoryGame
//
//  Created by Julia Frederico on 25/10/22.
//

import UIKit

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
        resetGame()
        updateView()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? GameLevelViewController else { return }
        destination.delegate = self
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
        // Guarding for:
        //  - card index isn't already selected
        //  - less than two card indexes are selected
        guard selectedIndexes.firstIndex(of: indexPath.row) == nil,
              selectedIndexes.count < 2 else { return false }

        selectedIndexes.append(indexPath.row)
        collectionView.reloadData()

        if self.selectedIndexes.count == 2 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { // in seconds
                if self.selectedCardsMatch() {
                    self.updateScore(with: self.score + 2)
                }
    
                self.archiveSelectedCards()
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

    func resetGame() {
        score = 0 // Reset score
        selectedIndexes = [] // Reset selected indexes
        shuffleGameCards() // Shuffle cards
    }
    
    func archiveSelectedCards() {
        if selectedCardsMatch() {
            // Remove matched cards from gameCards
            let maxIndex = selectedIndexes.max()!
            let minIndex = selectedIndexes.min()!
            gameCards.remove(at: maxIndex)
            gameCards.remove(at: minIndex)
            
            // Reset selected indexes
            selectedIndexes = []
            
            // Update view
            collectionView.deleteItems(at: [IndexPath(row: maxIndex, section: 0), IndexPath(row: minIndex, section: 0)])
        } else {
            // Reset selected indexes
            selectedIndexes = []
            
            // Update view
            collectionView.reloadData()
        }
    }
    
    func selectedCardsMatch() -> Bool {
        guard selectedIndexes.count == 2 else { return false }
        let firstCard = gameCards[selectedIndexes[0]]
        let secondCard = gameCards[selectedIndexes[1]]
        return firstCard == secondCard
    }

    func updateScore(with newScore: Int? = nil) {
        if let newScore = newScore { score = newScore }
        scoreBarButtonItem.title = "Score: \(score)"
    }

    func updateView() {
        updateScore()
        collectionView.reloadData()
    }

}

extension CardsCollectionViewController: GameLevelDelegate {

    func didSetGameLevel(to level: GameLevel) {
        gameLevel = level
        resetGame()
        updateView()
    }

}

extension CardsCollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width / 2
        return CGSize(width: width - 18, height: width - 18)
    }

}
