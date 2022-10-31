//
//  EntryDetailViewController.swift
//  JournalCD
//
//  Created by Julia Frederico on 31/10/22.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    // MARK: Properties and outlets
    
    var entry: Entry?
    var journal: Journal?
    
    @IBOutlet weak var entryTitleTextField: UITextField!
    @IBOutlet weak var entryTextView: UITextView!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()
    }
    
    // MARK: - Actions

    @IBAction func didPressSaveButton(_ sender: UIBarButtonItem) {
        guard let title = entryTitleTextField.text,
                  !title.isEmpty else { return }
        
        if let entry = entry {
            EntryController.update(entry: entry, withTitle: title, text: entryTextView.text ?? "")
        } else if let journal = journal {
            EntryController.addEntry(to: journal, withTitle: title, text: entryTextView.text ?? "")
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helpers
    
    func updateView() {
        guard let entry = entry else { return }

        entryTitleTextField.text = entry.title
        entryTextView.text = entry.text
    }

}
