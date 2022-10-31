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
    
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        updateView()
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ToEntryDetailVC",
              let destination = segue.destination as? EntryDetailViewController,
              let indexPath = tableView.indexPathForSelectedRow,
              let journal = journal else { return }
        
        let entry = journal.mutableEntries[indexPath.row]
        
        destination.entry = entry
    }
    
    // MARK: - Helpers
    
    func updateView() {
        guard let journal = journal else {
            return
        }
        
        title = journal.title
    }

}

extension EntryListViewController: UITableViewDelegate {
    
}

extension EntryListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let journal = journal else { return 0 }
        
        return journal.mutableEntries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let journal = journal else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EntryCell", for: indexPath)
        
        let entry = journal.mutableEntries[indexPath.row]
        
        cell.textLabel?.text = entry.title
        cell.detailTextLabel?.text = entry.formattedDate
        
        return cell
    }
    
}
