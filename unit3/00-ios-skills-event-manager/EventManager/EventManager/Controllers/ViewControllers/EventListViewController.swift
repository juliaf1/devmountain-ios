//
//  EventListViewController.swift
//  EventManager
//
//  Created by Julia Frederico on 09/11/22.
//

import UIKit

class EventListViewController: UIViewController {
    
    // MARK: - Properties
    
    var safeArea: UILayoutGuide {
        return self.view.safeAreaLayoutGuide
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()

        setUpViews()
        setUpNavigationBar()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
    }
    
    // MARK: - Actions
    
    // MARK: - Helpers
    
    func setUpViews() {
        self.view.backgroundColor = .systemGray6

        self.view.addSubview(tableView)
        
        constraintTableView()
    }
    
    func setUpNavigationBar() {
        self.navigationItem.title = "Events"
        self.navigationItem.setRightBarButton(addEventButton, animated: true)
    }

    func constraintTableView() {
        tableView.anchor(top: safeArea.topAnchor, bottom: safeArea.bottomAnchor, leading: safeArea.leadingAnchor, trailing: safeArea.trailingAnchor, marginTop: 0, marginBottom: 0, marginLeft: 0, marginRight: 0)
    }
    
    func configureTableView() {
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
        tableView.backgroundColor = .systemGray6
        return tableView
    }()
    
    var addEventButton: UIBarButtonItem = {
       let button = UIBarButtonItem()
        button.title = "🔥"
        return button
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
