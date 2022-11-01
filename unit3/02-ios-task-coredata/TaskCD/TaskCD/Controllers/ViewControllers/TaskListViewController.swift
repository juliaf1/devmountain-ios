//
//  TaskListViewController.swift
//  TaskCD
//
//  Created by Julia Frederico on 31/10/22.
//

import UIKit

class TaskListViewController: UIViewController {
    
    // MARK: - Properties and outlets
    
    let controller = TaskController.shared
    
    var tasks: [Task] {
        return controller.incompleteTasks + controller.completedTasks
    }
    
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Actions

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ToTaskDetailVC",
              let destination = segue.destination as? TaskDetailViewController,
              let indexPath = tableView.indexPathForSelectedRow else { return }
        
        destination.task = tasks[indexPath.row]
    }
    
    // MARK: - Helpers

}

extension TaskListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            let task = tasks[indexPath.row]
            controller.delete(task)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        default:
            break
        }
    }
    
}

extension TaskListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as? TaskTableViewCell else { return UITableViewCell() }
        
        let task = tasks[indexPath.row]
        cell.updateView(with: task)
        return cell
    }
}
