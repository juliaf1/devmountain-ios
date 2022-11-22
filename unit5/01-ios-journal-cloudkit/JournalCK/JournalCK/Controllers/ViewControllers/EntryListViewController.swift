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
    }
    
    // MARK: - Views
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray6
        tableView.separatorStyle = .none

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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
