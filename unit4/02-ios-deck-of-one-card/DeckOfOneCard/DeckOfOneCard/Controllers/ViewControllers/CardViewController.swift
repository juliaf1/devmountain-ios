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

    // MARK: - Propreties
    
    var card: Card? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCard()
    }
    
    // MARK: - Actions
    
    @IBAction func didPressDrawCardButton(_ sender: UIButton) {
    }
    
    // MARK: - Helpers
    
    func fetchCard() {
        CardController.fetchOneCard { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let card):
                    self.card = card
                case .failure(let error):
                    print(error)
                    // push alert
                }
            }
        }
    }
    
    func updateViews() {
        guard let card = card else {
            return
        }
        
        cardNameLabel.text = "\(card.value) of \(card.suit)".capitalized
        // update photo
    }

}
