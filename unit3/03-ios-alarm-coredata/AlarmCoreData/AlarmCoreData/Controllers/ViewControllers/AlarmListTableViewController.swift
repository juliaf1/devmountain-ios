//
//  AlarmListTableViewController.swift
//  AlarmCoreData
//
//  Created by Julia Frederico on 01/11/22.
//

import UIKit

class AlarmListTableViewController: UITableViewController {
    
    // MARK: - Properties and outlets
    
    let controller = AlarmController.shared
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller.alarms.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AlarmCell", for: indexPath) as? AlarmTableViewCell else { return UITableViewCell() }

        let alarm = controller.alarms[indexPath.row]
        cell.delegate = self
        cell.updateView(with: alarm)
        
        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ToAlarmDetailVC",
              let destination = segue.destination as? AlarmDetailTableViewController,
              let indexPath = tableView.indexPathForSelectedRow else { return }
        
        destination.alarm = controller.alarms[indexPath.row]
    }

}

extension AlarmListTableViewController: AlarmCellDelegate {

    func didToggleEnabled(for cell: AlarmTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let alarm = controller.alarms[indexPath.row]
        controller.toggleEnabled(for: alarm)
        cell.updateView(with: alarm)
    }

}
