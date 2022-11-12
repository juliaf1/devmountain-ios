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
    }
    
    // MARK: - Actions
    
    @IBAction func didPressDrawCardButton(_ sender: UIButton) {
    }
    
    // MARK: - Helpers
    
    func updateViews() {
        
    }

}
