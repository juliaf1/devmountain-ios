//
//  JournalListViewController.swift
//  Journal
//
//  Created by Julia Frederico on 14/10/22.
//

import UIKit

class JournalListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Properties
    
    let journalController = JournalController.shared
    
    // MARK: - Outlets
    
    @IBOutlet weak var journalTitleTextField: UITextField!
    @IBOutlet weak var journalListTableView: UITableView!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        journalController.loadFromPersistentStorage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        journalListTableView.reloadData()
    }
    
    // MARK: - Table View Data Source
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return journalController.journals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = journalListTableView.dequeueReusableCell(withIdentifier: "journalCell", for: indexPath)
        
        let journal = journalController.journals[indexPath.row]
        cell.textLabel?.text = journal.title ?? ""
        cell.detailTextLabel?.text = String(journal.entries.count)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let journal = journalController.journals[indexPath.row]
        journalController.delete(journal: journal)
        tableView.reloadData()
    }
    
    // MARK: - Actions

    @IBAction func createNewJournalButtonTapped(_ sender: Any) {
        guard let title = journalTitleTextField.text else { return }
        journalController.create(journalWithTitle: title)
        journalListTableView.reloadData()
        journalTitleTextField.text = ""
    }

    // MARK: - Helpers

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = journalListTableView.indexPathForSelectedRow,
              let destination = segue.destination as? EntriesTableViewController else { return }
        
        let journalToSend = journalController.journals[indexPath.row]
        destination.journal = journalToSend
    }

}
