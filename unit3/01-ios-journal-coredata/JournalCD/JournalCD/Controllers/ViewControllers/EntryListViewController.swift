//
//  EntryListViewController.swift
//  JournalCD
//
//  Created by Julia Frederico on 31/10/22.
//

import UIKit

class EntryListViewController: UIViewController {
    
    // MARK: - Properties and outlets
    
    var journal: Journal?
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    // MARK: - Helpers
    
    func updateView() {
        guard let journal = journal else {
            return
        }
        
        title = journal.title
    }

}
