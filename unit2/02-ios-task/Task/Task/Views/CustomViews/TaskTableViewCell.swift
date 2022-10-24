//
//  TaskTableViewCell.swift
//  Task
//
//  Created by Julia Frederico on 24/10/22.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    // MARK: - Properties

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var isCompletedButton: UIButton!
    
    // MARK: - Actions
    
    @IBAction func didToggleCompleteButton(_ sender: UIButton) {
    }
    
}
