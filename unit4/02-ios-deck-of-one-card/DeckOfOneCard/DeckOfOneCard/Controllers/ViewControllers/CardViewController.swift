//
//  CardViewController.swift
//  DeckOfOneCard
//
//  Created by Julia Frederico on 12/11/22.
//

import UIKit

class CardViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var cardNameLabel: UILabel!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCard()
    }
    
    // MARK: - Actions
    
    @IBAction func didPressDrawCardButton(_ sender: UIButton) {
        fetchCard()
    }
    
    // MARK: - Helpers
    
    func fetchCard() {
        CardController.fetchOneCard { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let card):
                    self.fetchImage(for: card.imageURL)
                    self.cardNameLabel.text = "\(card.value) of \(card.suit)".capitalized
                case .failure(let error):
                    print(error)
                    self.presentErrorToUser(error: error)
                }
            }
        }
    }
    
    func fetchImage(for url: URL) {
        CardController.fetchCardImage(for: url) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.cardImageView.image = image
                case .failure(let error):
                    print(error)
                    self.presentErrorToUser(error: error)
                }
            }
        }
    }

}
