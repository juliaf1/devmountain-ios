//
//  EntriesTableViewController.swift
//  Journal
//
//  Created by Julia Frederico on 13/10/22.
//

import UIKit

class EntriesTableViewController: UITableViewController {
    
    // MARK: - Properties
    
//    let entryController = EntryController.shared
    var journal: Journal?
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let total = journal?.entries.count ?? 0
        return total
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let journal = journal else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)

        let entry = journal.entries[indexPath.row]
        cell.textLabel?.text = entry.title
        cell.detailTextLabel?.text = entry.formattedDate

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let journal = journal else { return }
        let entry = journal.entries[indexPath.row]
        EntryController.delete(entry: entry, journal: journal)
        tableView.reloadData()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let journal = journal else { return }

        if segue.identifier == "toEntryDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? EntryDetailViewController else { return }
            
            let entryToSend = journal.entries[indexPath.row]
            destination.entry = entryToSend
            destination.journal = journal
        } else if segue.identifier == "createNewEntry" {
            guard let destination = segue.destination as? EntryDetailViewController else { return }
            destination.journal = journal
        }
    }

}
