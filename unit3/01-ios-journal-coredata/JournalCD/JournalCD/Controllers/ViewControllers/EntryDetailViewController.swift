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
        
        entryTitleTextField.delegate = self
        entryTextView.delegate = self
        
        setUpDismissKeyboardTap()

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
        guard let entry = entry,
              let notes = entry.text else { return }

        entryTitleTextField.text = entry.title
        
        if notes.isEmpty {
            entryTextView.text = "Notes"
            entryTextView.textColor = .lightGray
        } else {
            entryTextView.text = notes
            entryTextView.textColor = .darkGray
        }
    }
    
    func setUpDismissKeyboardTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}


extension EntryDetailViewController: UITextViewDelegate, UITextFieldDelegate {

    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView.text == "Notes" {
            textView.text = ""
            textView.textColor = .darkGray
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
//    func textViewDidEndEditing(_ textView: UITextView) {
//        if textView.text == "" {
//            textView.text = "Notes"
//            textView.textColor = .lightGray
//        }
//    }

}
