//
//  TaskDetailViewController.swift
//  Task
//
//  Created by Julia Frederico on 24/10/22.
//

import UIKit

class TaskDetailViewController: UIViewController {

    // MARK: - Properties and Outlets

    var taskController = TaskController.shared
    var task: Task?

    @IBOutlet weak var taskTitleTextField: UITextField!
    @IBOutlet weak var taskNotesTextView: UITextView!
    @IBOutlet weak var taskDeadlineDatePicker: UIDatePicker!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskTitleTextField.delegate = self
        taskNotesTextView.delegate = self
        
        setUpDismissKeyboardTap()
    
        updateViews()
    }

    // MARK: - Actions

    @IBAction func saveTaskButtonPressed(_ sender: UIBarButtonItem) {
        guard let title = taskTitleTextField.text, !title.isEmpty else { return }

        if let task = task {
            taskController.update(task, title: title, notes: taskNotesTextView.text, deadline: taskDeadlineDatePicker.date)
            _ = navigationController?.popViewController(animated: true)
        } else {
            taskController.create(taskWithTitle: title, notes: taskNotesTextView.text, deadline: taskDeadlineDatePicker.date)
            _ = navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: - Helpers
    
    func updateViews() {
        guard let task = task else { return }
        let notes = task.notes == nil || task.notes!.isEmpty ? "Enter notes..." : task.notes!
        taskTitleTextField.text = task.title
        taskNotesTextView.text = notes
        taskDeadlineDatePicker.date = task.deadline ?? Date()
    }

    func setUpDismissKeyboardTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}

extension TaskDetailViewController: UITextFieldDelegate, UITextViewDelegate {
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView.text == "Enter notes..." {
            textView.text = ""
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
