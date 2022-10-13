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
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IBActions

    @IBAction func clearEntryTitleAndText(_ sender: Any) {
    }
}
