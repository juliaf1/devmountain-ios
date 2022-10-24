//
//  TaskTableViewCell.swift
//  Task
//
//  Created by Julia Frederico on 24/10/22.
//

import UIKit

protocol TaskTableViewCellDelegate {
    func didToggleCompleteButton(for cell: TaskTableViewCell)
}

class TaskTableViewCell: UITableViewCell {

    // MARK: - Properties

    var delegate: TaskTableViewCellDelegate?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var isCompletedButton: UIButton!

    // MARK: - Actions

    @IBAction func didToggleCompleteButton(_ sender: UIButton) {
        delegate?.didToggleCompleteButton(for: self)
    }

}
