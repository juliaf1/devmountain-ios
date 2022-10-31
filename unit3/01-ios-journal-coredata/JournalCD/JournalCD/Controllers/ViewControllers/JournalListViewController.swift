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
        let alert = UIAlertController(title: "Add new journal", message: "Please insert your new journal title", preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "Title"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let confirmAction = UIAlertAction(title: "Save", style: .default) { _ in
            guard let textField = alert.textFields?[0],
                  let title = textField.text,
                  !title.isEmpty else { return }
            self.journalController.create(title: title)
            self.tableView.reloadData()
        }
        
        [confirmAction, cancelAction].forEach { alert.addAction($0) }
        
        present(alert, animated: true)
    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}

extension JournalListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let journal = journals[indexPath.row]
            journalController.delete(journal)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
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
