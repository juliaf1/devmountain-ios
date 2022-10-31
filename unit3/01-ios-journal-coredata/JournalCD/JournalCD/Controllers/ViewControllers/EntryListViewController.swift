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
    
    var entries: [Entry] {
        guard let journal = journal else { return [] }
        let entries = journal.entries as? Set<Entry> ?? []
        return entries.sorted { $0.timestamp! > $1.timestamp! }
    }
    
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        updateView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? EntryDetailViewController else { return }

        if segue.identifier == "ToEntryDetailVC",
           let indexPath = tableView.indexPathForSelectedRow {
            let entry = entries[indexPath.row]
            destination.entry = entry
        } else if let journal = journal {
            destination.journal = journal
        }
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
        return entries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EntryCell", for: indexPath)
        
        let entry = entries[indexPath.row]
        
        cell.textLabel?.text = entry.title
        cell.detailTextLabel?.text = entry.formattedDate
        
        return cell
    }
    
}
