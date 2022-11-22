//
//  EntryListViewController.swift
//  JournalCK
//
//  Created by Julia Frederico on 22/11/22.
//

import UIKit

class EntryListViewController: UIViewController {
    
    // MARK: - Properties
    
    var safeArea: UILayoutGuide {
        return self.view.safeAreaLayoutGuide
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        
        setupViews()
        constraintTableView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()
        loadData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateViews), name: didSetEntriesNotificationName, object: nil)
    }
    
    // MARK: - Helper Methods
    
    func setupViews() {
        self.view.backgroundColor = .systemGray6
        
        self.navigationItem.title = "Entries"
        self.navigationItem.rightBarButtonItem = addEntryButton
        
        self.view.addSubview(tableView)
    }
    
    func constraintTableView() {
        tableView.anchor(top: safeArea.topAnchor, bottom: safeArea.bottomAnchor, leading: safeArea.leadingAnchor, trailing: safeArea.trailingAnchor, marginTop: 0, marginBottom: 0, marginLeft: 0, marginRight: 0)
    }
    
    func configureViews() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(EntryTableViewCell.self, forCellReuseIdentifier: Strings.entryCellIdentifier)
        
        addEntryButton.target = self
        addEntryButton.action = #selector(didPressAddEntryButton)
    }
    
    @objc func updateViews() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func loadData() {
        EntryController.shared.fetchAllEntries { error in
            DispatchQueue.main.async {
                if let error = error {
                    self.presentErrorToUser(error)
                } else {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    @objc func didPressAddEntryButton() {
        let detailVC = EntryDetailViewController()
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    // MARK: - Views
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray6
        tableView.separatorInset = .zero
        tableView.separatorColor = Colors.brandPrimaryTransparent

        return tableView
    }()
    
    let addEntryButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.tintColor = Colors.brandPrimary
        button.image = UIImage(systemName: "plus")

        return button
    }()

}

extension EntryListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EntryController.shared.entries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Strings.entryCellIdentifier, for: indexPath) as? EntryTableViewCell else { return UITableViewCell() }
        
        let entry = EntryController.shared.entries[indexPath.row]
        cell.entry = entry
        
        return cell
    }
    
}
