//
//  TaskTableViewCell.swift
//  TaskCD
//
//  Created by Julia Frederico on 31/10/22.
//

import UIKit

protocol TaskCellDelegate {
    func toggleCompleteTask(for cell: TaskTableViewCell)
}

class TaskTableViewCell: UITableViewCell {

    // MARK: - Properties and outlets
    
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var taskCompleteButton: UIButton!
    
    var delegate: TaskCellDelegate?
    
    // MARK: - Actions
    
    @IBAction func didPressCompleteTaskButton(_ sender: UIButton) {
        delegate?.toggleCompleteTask(for: self)
    }
    
    // MARK: - Helpers
    
    func updateView(with task: Task) {
        let image = UIImage(systemName: task.completed ? Strings.completeTaskImageName : Strings.incompleteTaskImageName)
        
        taskNameLabel.text = task.name
        taskCompleteButton.setImage(image, for: .normal)
    }


}
