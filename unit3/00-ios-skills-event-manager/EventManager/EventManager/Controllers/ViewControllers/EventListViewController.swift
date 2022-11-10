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
        configureAddEventButton()
    }

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
    
    func configureAddEventButton() {
        addEventButton.target = self
        addEventButton.action = #selector(didPressAddEventButton(sender:))
    }
    
    @objc func didPressAddEventButton(sender: UIBarButtonItem) {
        let newVC = EventDetailViewController()
        self.navigationController?.pushViewController(newVC, animated: true)
    }
    
    func event(withIndexPath indexPath: IndexPath) -> Event? {
        switch EventSections(rawValue: indexPath.section) {
        case .attending:
            return eventController.attendingEvents[indexPath.row]
        case .notAttending:
            return eventController.notAttendingEvents[indexPath.row]
        case .none:
            return nil
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = EventDetailViewController()

        if let event = event(withIndexPath: indexPath) {
            detailVC.event = event
        }

        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Strings.eventCellIdentifier, for: indexPath) as? EventTableViewCell,
              let event = event(withIndexPath: indexPath) else { return UITableViewCell() }

        cell.event = event
        cell.delegate = self

        return cell
    }
    
}

extension EventListViewController: EventTableViewCellDelegate {
    
    func toggleAttendance(of event: Event) {
        eventController.toggleAttendance(of: event)
        tableView.reloadData()
    }
    
}
