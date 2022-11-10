//
//  EventListViewController.swift
//  EventManager
//
//  Created by Julia Frederico on 09/11/22.
//

import UIKit

class EventListViewController: UIViewController {
    
    // MARK: - Properties
    
    let eventController = EventController.shared
    
    var safeArea: UILayoutGuide {
        return self.view.safeAreaLayoutGuide
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()

        setUpSubviews()
        setUpNavigationBar()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
    }
    
    // MARK: - Actions
    
    // MARK: - Helpers
    
    func setUpSubviews() {
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
        tableView.register(EventTableViewCell.self, forCellReuseIdentifier: Strings.eventCellIdentifier)
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Spacings.largeHeight + (2 * Spacings.mediumSpacing)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let eventSection = EventSections(rawValue: section) {
            return eventSection.title
        } else {
            return ""
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch EventSections(rawValue: section) {
        case .attending:
            return eventController.attendingEvents.count
        case .notAttending:
            return eventController.notAttendingEvents.count
        case .none:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Strings.eventCellIdentifier, for: indexPath) as? EventTableViewCell else { return UITableViewCell() }
        
        switch EventSections(rawValue: indexPath.section) {
        case .attending:
            let event = eventController.attendingEvents[indexPath.row]
            cell.event = event
        case .notAttending:
            let event = eventController.notAttendingEvents[indexPath.row]
            cell.event = event
        case .none:
            break
        }
        
        return cell
    }
    
}
