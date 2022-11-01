//
//  TaskListViewController.swift
//  TaskCD
//
//  Created by Julia Frederico on 31/10/22.
//

import UIKit

class TaskListViewController: UIViewController {
    
    enum TaskFilter: Int {
        case all
        case incomplete
        case complete
    }
    
    // MARK: - Properties and outlets
    
    let controller = TaskController.shared
    var taskType = TaskFilter.all
    
    var tasks: [Task] {
        switch taskType {
        case .all:
            return (controller.incompleteTasks + controller.completedTasks).sorted { $0.name! > $1.name! }
        case .incomplete:
            return controller.incompleteTasks.sorted { $0.name! > $1.name! }
        case .complete:
            return controller.completedTasks.sorted { $0.name! > $1.name! }
        }
        
    }
    
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: - Actions
    
    @IBAction func didChangeSegmentValue(_ sender: UISegmentedControl) {
        taskType = TaskFilter(rawValue: sender.selectedSegmentIndex) ?? TaskFilter.all
        tableView.reloadData()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ToTaskDetailVC",
              let destination = segue.destination as? TaskDetailViewController,
              let indexPath = tableView.indexPathForSelectedRow else { return }
        
        destination.task = tasks[indexPath.row]
    }

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
        cell.delegate = self
        cell.task = task
        cell.updateView(with: task)
        return cell
    }
}

extension TaskListViewController: TaskCellDelegate {
    
    func toggleCompleteTask(for task: Task) {
        controller.toggleCompleted(for: task)
        tableView.reloadData()
    }
    
}
