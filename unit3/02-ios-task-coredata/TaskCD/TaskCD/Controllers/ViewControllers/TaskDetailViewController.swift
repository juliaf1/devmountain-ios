//
//  TaskDetailViewController.swift
//  TaskCD
//
//  Created by Julia Frederico on 31/10/22.
//

import UIKit

class TaskDetailViewController: UIViewController {
    
    // MARK: - Properties and outlets
    
    var task: Task?
    
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskNotesTextView: UITextView!
    @IBOutlet weak var taskDueDatePicker: UIDatePicker!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()
    }
    
    // MARK: - Actions
    
    @IBAction func didPressSaveButton(_ sender: UIBarButtonItem) {
    }

    @IBAction func didChangeDateValue(_ sender: UIDatePicker) {
    }
    
    // MARK: - Helpers
    
    func updateView() {
        guard let task = task else { return }
        
        taskNameTextField.text = task.name
        taskNotesTextView.text = task.notes ?? "Notes"
        taskDueDatePicker.date = task.dueDate ?? Date()
    }

}
