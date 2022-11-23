//
//  ContactListViewController.swift
//  Contacts
//
//  Created by Julia Frederico on 23/11/22.
//

import UIKit

class ContactListViewController: UIViewController {
    
    // MARK: - Properties
    
    let controller = ContactController.shared
    
    var contacts: [Contact] {
        return controller.contacts
    }
    
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        configureTableView()
        loadData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadView), name: contactsSetNotificationName, object: nil)
    }
    
    // MARK: - Helpers
    
    func setupViews() {
        navigationItem.rightBarButtonItem?.tintColor = .systemPink
        
        tableView.separatorColor = .systemPink.withAlphaComponent(0.4)
        tableView.separatorInset = .zero
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func loadData() {
        controller.fetchContacts { error in
            self.handleResponse(error: error)
        }
    }
    
    func handleResponse(error: ContactError?) {
        DispatchQueue.main.async {
            if let error = error {
                self.presentErrorToUser(error)
            }
        }
    }
    
    @objc func reloadView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC",
           let destination = segue.destination as? ContactDetailViewController,
           let indexPath = tableView.indexPathForSelectedRow {
            let contact = contacts[indexPath.row]
            destination.contact = contact
        }
    }

}

extension ContactListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as? ContactTableViewCell else { return UITableViewCell() }
        
        let contact = contacts[indexPath.row]
        cell.contact = contact
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112
    }
    
}
