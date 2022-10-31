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
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()
    }
    
    // MARK: - Actions
    
    // MARK: - Helpers
    
    func updateView() {
        guard let entry = entry else { return }
        
        title = entry.title
    }

}
