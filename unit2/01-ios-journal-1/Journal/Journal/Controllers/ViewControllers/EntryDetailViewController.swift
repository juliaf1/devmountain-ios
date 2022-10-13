//
//  EntryDetailViewController.swift
//  Journal
//
//  Created by Julia Frederico on 13/10/22.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    let entryController = EntryController.shared
    var entry: Entry?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    // MARK: - IBActions

    @IBAction func clearEntryTitleAndText(_ sender: Any) {
        titleTextField?.text = ""
        bodyTextView?.text = ""
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        if let _ = entry {
            print("wip - update entry title, text and timestamp")
        } else {
            self.entry = entryController.create(entryWithTitle: titleTextField.text ?? "", text: bodyTextView.text ?? "")
        }
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - Helpers
    
    func updateViews() {
        guard let entry = entry else { return }
        
        titleTextField.text = entry.title
        bodyTextView.text = entry.text
    }
}
