//
//  AlarmDetailTableViewController.swift
//  AlarmCoreData
//
//  Created by Julia Frederico on 01/11/22.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {
    
    // MARK: - Properties and outlets
    
    var alarm: Alarm?
    var alarmEnabled = true
    
    @IBOutlet weak var alarmFireDatePicker: UIDatePicker!
    @IBOutlet weak var alarmTitleField: UITextField!
    @IBOutlet weak var alarmEnabledButton: UIButton!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        NotificationManager().requestPermission()
    }

    // MARK: - Actions
    
    @IBAction func didTapAlarmEnabledButton(_ sender: UIButton) {
        alarmEnabled = !alarmEnabled
        designIsEnabledButton()
    }
    
    @IBAction func didTapSaveButton(_ sender: UIBarButtonItem) {
        guard let title = alarmTitleField.text,
              !title.isEmpty else { return }
        
        let date = alarmFireDatePicker.date
        
        if let alarm = alarm {
            AlarmController.shared.update(alarm, title: title, fireDate: date, enabled: alarmEnabled)
        } else {
            AlarmController.shared.createAlarm(withTitle: title, fireDate: date, enabled: alarmEnabled)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helpers
    
    func updateView() {
        guard let alarm = alarm else {
            designIsEnabledButton()
            return
        }
        alarmFireDatePicker.date = alarm.fireDate!
        alarmTitleField.text = alarm.title
        alarmEnabled = alarm.enabled
        designIsEnabledButton()
    }
    
    func designIsEnabledButton() {
        switch alarmEnabled {
        case true:
            alarmEnabledButton.backgroundColor = .white
            alarmEnabledButton.setTitle("On", for: .normal)
        case false:
            alarmEnabledButton.backgroundColor = .darkGray
            alarmEnabledButton.setTitle("Off", for: .normal)
        }
    }

}
