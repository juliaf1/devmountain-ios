//
//  TaskDetailViewController.swift
//  Task
//
//  Created by Julia Frederico on 24/10/22.
//

import UIKit

class TaskDetailViewController: UIViewController {

    // MARK: - Properties and Outlets

    var task: Task?

    @IBOutlet weak var taskTitleTextField: UITextField!
    @IBOutlet weak var taskNotesTextView: UITextView!
    @IBOutlet weak var taskDeadlineDatePicker: UIDatePicker!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Actions

    @IBAction func saveTaskButtonPressed(_ sender: UIBarButtonItem) {
    }

}
