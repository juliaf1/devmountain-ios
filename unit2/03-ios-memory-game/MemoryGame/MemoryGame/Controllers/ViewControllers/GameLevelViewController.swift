//
//  GameLevelViewController.swift
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

protocol GameLevelDelegate {
    func didSetGameLevel(to level: GameLevel)
}

class GameLevelViewController: UIViewController {
    
    // MARK: - Properties and Outlets
    
    var delegate: GameLevelDelegate?
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: Update view highlighting current level
    }
    
    // MARK: - Actions
    
    @IBAction func didPressBeginnerButton(_ sender: Any) {
        delegate?.didSetGameLevel(to: .beginner)
        self.dismiss(animated: true)
    }

    @IBAction func didPressIntermediateButton(_ sender: Any) {
        delegate?.didSetGameLevel(to: .intermediate)
        self.dismiss(animated: true)
    }

    @IBAction func didPressAdvancedButton(_ sender: Any) {
        delegate?.didSetGameLevel(to: .advanced)
        self.dismiss(animated: true)
    }

    @IBAction func didPressMasterButton(_ sender: Any) {
        delegate?.didSetGameLevel(to: .master)
        self.dismiss(animated: true)
    }

}
