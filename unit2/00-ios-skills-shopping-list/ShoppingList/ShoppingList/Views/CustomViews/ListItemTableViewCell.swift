//
//  ListItemTableViewCell.swift
//  ShoppingList
//
//  Created by Julia Frederico on 25/10/22.
//

import UIKit

protocol ListItemCellDelegate {
    func didToggleCheck(for cell: ListItemTableViewCell)
}

class ListItemTableViewCell: UITableViewCell {
    
    // MARK: - Properties and outlets
    
    @IBOutlet weak var listItemLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!

    var delegate: ListItemCellDelegate?
    
    // MARK: - Actions

    @IBAction func didPressCheckButton(_ sender: UIButton) {
        delegate?.didToggleCheck(for: self)
    }
    
    // MARK: - Helpers
    
    func updateView(for item: ListItem) {
        let checkImage = item.checked ? "checkmark.circle" : "circle"
        listItemLabel.text = item.name
        checkButton.setImage(UIImage(systemName: checkImage), for: .normal)
    }
    
}
