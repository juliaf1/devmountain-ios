//
//  EventListViewController.swift
//  EventManager
//
//  Created by Julia Frederico on 09/11/22.
//

import UIKit

class EventListViewController: UIViewController {
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()

        self.view.backgroundColor = .systemIndigo
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
    }
    
    // MARK: - Actions
    
    // MARK: - Helpers
    
    func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        // configure and register cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // todo
    }
    
    // MARK: - Views
    
    var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

}

extension EventListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
