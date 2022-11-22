//
//  EntryListViewController.swift
//  JournalCK
//
//  Created by Julia Frederico on 22/11/22.
//

import UIKit

// Refactor colors to helper file
let brandColor = #colorLiteral(red: 1, green: 0.2706922889, blue: 0.2406029403, alpha: 1)

class EntryListViewController: UIViewController {
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        
        setupViews()
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
    }
    
    func configureViews() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: - Views
    
    let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    let addEntryButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.tintColor = brandColor
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
