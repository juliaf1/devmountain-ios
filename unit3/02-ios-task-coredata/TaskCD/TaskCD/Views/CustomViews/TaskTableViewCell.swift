//
//  TaskTableViewCell.swift
//  TaskCD
//
//  Created by Julia Frederico on 31/10/22.
//

import UIKit

protocol TaskCellDelegate {
    func toggleCompleteTask(for task: Task)
}

class TaskTableViewCell: UITableViewCell {

    // MARK: - Properties and outlets
    
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var taskCompleteButton: UIButton!
    
    var task: Task?
    var delegate: TaskCellDelegate?
    
    // MARK: - Actions
    
    @IBAction func didPressCompleteTaskButton(_ sender: UIButton) {
        guard let task = task else { return }
        delegate?.toggleCompleteTask(for: task)
    }
    
    // MARK: - Helpers
    
    func updateView(with task: Task) {
        let image = UIImage(systemName: task.completed ? Strings.completeTaskImageName : Strings.incompleteTaskImageName)
        
        taskNameLabel.text = task.name
        taskCompleteButton.setImage(image, for: .normal)
    }


}
