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

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Actions
    
    
    @IBAction func didPressAddJournalButton(_ sender: UIButton) {
    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}

extension JournalListViewController: UITableViewDelegate {
    
}

extension JournalListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return journals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JournalCell", for: indexPath)
        
        let journal = journals[indexPath.row]
        
        cell.textLabel?.text = journal.title
        cell.detailTextLabel?.text = "\(journal.entries?.count ?? 0) entries"
        
        return cell
    }

}
