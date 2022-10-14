//
//  EntryDetailViewController.swift
//  Journal
//
//  Created by Julia Frederico on 13/10/22.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    // MARK: - Properties

    var entry: Entry?
    var journal: Journal?

    // MARK: - IBOutlets
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // when conforming to text view/field delegates, we need to set up the outlets delegate: bodyTextView.delegate = self

        setUpDismissKeyboardTap()
        updateViews()
    }
    
    // MARK: - IBActions

    @IBAction func clearEntryTitleAndText(_ sender: Any) {
        titleTextField?.text = ""
        bodyTextView?.text = ""
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let journal = journal else { return }
        let title = titleTextField.text ?? ""
        let text = bodyTextView.text ?? ""
        
        if let entry = entry {
            self.entry = EntryController.update(entry: entry, title: title, text: text)
        } else {
            self.entry = EntryController.create(entryWithTitle: title, text: text, journal: journal)
        }
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - Helpers
    
    func updateViews() {
        guard let entry = entry else { return }
        
        titleTextField.text = entry.title
        bodyTextView.text = entry.text
    }
    
    func setUpDismissKeyboardTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

/*
extension EntryDetailViewController: UITextViewDelegate, UITextFieldDelegate {
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        view.endEditing(true)
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        // functions will run for every text view / title field outlet that has its delegate set as this VC
        // check what view/field was triggered by comparing them to the outlets textView == myOutlet
        // print(textView.text)
    }
}
*/
