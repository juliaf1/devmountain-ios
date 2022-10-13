//
//  EntriesTableViewController.swift
//  Journal
//
//  Created by Julia Frederico on 13/10/22.
//

import UIKit

class EntriesTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    let entryController = EntryController.shared
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entryController.entries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)

        let entry = entryController.entries[indexPath.row]
        cell.textLabel?.text = entry.title

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let entry = entryController.entries[indexPath.row]
        entryController.delete(entry: entry)
        tableView.reloadData()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
