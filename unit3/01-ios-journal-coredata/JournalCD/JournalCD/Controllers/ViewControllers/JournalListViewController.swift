//
//  JournalListViewController.swift
//  JournalCD
//
//  Created by Julia Frederico on 27/10/22.
//

import UIKit

class JournalListViewController: UIViewController {
    
    // MARK: - Properties and outlets
    
    let journalController = JournalController.shared

    var journals: [Journal] { journalController.journals }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}

extension JournalListViewController: UITableViewDelegate {
    
}

extension JournalListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return journals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }

}
