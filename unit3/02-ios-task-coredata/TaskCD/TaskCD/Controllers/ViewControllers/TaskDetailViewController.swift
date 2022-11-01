//
//  TaskDetailViewController.swift
//  TaskCD
//
//  Created by Julia Frederico on 31/10/22.
//

import UIKit

class TaskDetailViewController: UIViewController {
    
    // MARK: - Properties and outlets
    
    let controller = TaskController.shared
    
    var task: Task?
    
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskNotesTextView: UITextView!
    @IBOutlet weak var taskDueDatePicker: UIDatePicker!
    
    var date: Date?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()
    }
    
    // MARK: - Actions
    
    @IBAction func didPressSaveButton(_ sender: UIBarButtonItem) {
        guard let name = taskNameTextField.text,
              !name.isEmpty else { return }
        
        let notes = taskNotesTextView.text == "Notes" ? taskNotesTextView.text : nil

        if let task = task {
            controller.update(task, name: name, notes: notes, dueDate: date)
        } else {
            controller.createTask(name: name, notes: notes, dueDate: date)
        }
        
        navigationController?.popViewController(animated: true)
    }

    @IBAction func didChangeDateValue(_ sender: UIDatePicker) {
        date = taskDueDatePicker.date
    }
    
    // MARK: - Helpers
    
    func updateView() {
        guard let task = task else { return }
        
        taskNameTextField.text = task.name
        taskNotesTextView.text = task.notes ?? "Notes"
        taskDueDatePicker.date = task.dueDate ?? Date()
    }

}
