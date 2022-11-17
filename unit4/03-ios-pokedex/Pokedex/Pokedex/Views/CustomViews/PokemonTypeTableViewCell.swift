//
//  PokemonTypeTableViewCell.swift
//  Pokedex
//
//  Created by Julia Frederico on 17/11/22.
//

import UIKit

class PokemonTypeTableViewCell: UITableViewCell {
    
    // MARK: - Propreties and Outlets
    
    var type: PokemonType? {
        didSet {
            updateView()
        }
    }

    @IBOutlet weak var typeButton: UIButton!
    
    // MARK: - Actions

    @IBAction func didPressTypeButton(_ sender: UIButton) {
    }
    
    // MARK: - Helpers
    
    func updateView() {
        guard let type = type else { return }
        typeButton.setTitle(type.name.capitalized, for: .normal)
    }
    
}
