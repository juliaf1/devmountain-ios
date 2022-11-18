//
//  PokemonTypeTableViewCell.swift
//  Pokedex
//
//  Created by Julia Frederico on 17/11/22.
//

import UIKit

protocol PokemonTypeTableViewCellDelegate {
    func didSelectPokemonType(for cell: PokemonTypeTableViewCell) async
}

class PokemonTypeTableViewCell: UITableViewCell {
    
    // MARK: - Propreties and Outlets
    
    var delegate: PokemonTypeTableViewCellDelegate?

    @IBOutlet weak var typeButton: UIButton!
    
    // MARK: - Actions
    
    @IBAction func didPressTypeButton(_ sender: UIButton) {
        Task {
            await delegate?.didSelectPokemonType(for: self)
        }
    }
    
    // MARK: - Helpers
    
    func updateView(with type: PokemonType, isSelected: Bool) {
        typeButton.setTitle(type.name.capitalized, for: .normal)
        
        let color: UIColor? = isSelected ? UIColor(named: "GrayPurple") : .systemIndigo
        typeButton.backgroundColor = color
    }
    
}
