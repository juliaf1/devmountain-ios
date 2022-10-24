//
//  TaskListTableViewController.swift
//  Task
//
//  Created by Julia Frederico on 24/10/22.
//

import UIKit

class TaskListTableViewController: UITableViewController {
    
    // MARK: - Properties and Outlets

    let taskController = TaskController.shared

    var tasks: [Task] {
        taskController.tasks
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        taskController.loadFromStorage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Actions

    @IBAction func didPressEditButton(_ sender: UIBarButtonItem) {
        tableView.setEditing(!tableView.isEditing, animated: true)
    
        if tableView.isEditing {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didPressEditButton(_:)))
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(didPressEditButton(_:)))
        }
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)

        if let cell = cell as? TaskTableViewCell {
            let task = tasks[indexPath.row]
            cell.titleLabel.text = task.title
            cell.isCompletedButton.setBackgroundImage(UIImage(named: task.completed ? "complete" : "incomplete"), for: .normal)
            cell.delegate = self
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            let task = tasks[indexPath.row]
            taskController.delete(task)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            break
        case .insert:
            break
        case .none:
            break
        default:
            break
        }
    }

    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        taskController.rearrange(fromIndex: fromIndexPath.row, toIndex: to.row)
        
    }

    // MARK: - Helpers

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTaskDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? TaskDetailViewController else { return }
            
            let taskToSend = tasks[indexPath.row]
            destination.task = taskToSend
        }
    }

}

extension TaskListTableViewController: TaskTableViewCellDelegate {

    func didToggleCompleteButton(for cell: TaskTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let task = tasks[indexPath.row]
        taskController.toggleIsComplete(for: task)
        tableView.reloadData()
    }

}
