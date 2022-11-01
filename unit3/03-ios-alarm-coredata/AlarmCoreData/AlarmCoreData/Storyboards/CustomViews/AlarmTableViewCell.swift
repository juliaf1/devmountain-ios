//
//  AlarmTableViewCell.swift
//  AlarmCoreData
//
//  Created by Julia Frederico on 01/11/22.
//

import UIKit

protocol AlarmCellDelegate: AnyObject {
    func didToggleEnabled(for alarm: Alarm)
}

class AlarmTableViewCell: UITableViewCell {

    // MARK: - Properties and outlets
    
    var alarm: Alarm?
    weak var delegate: AlarmCellDelegate?
    
    @IBOutlet weak var alarmTitleLabel: UILabel!
    @IBOutlet weak var alarmFireDateLabel: UILabel!
    @IBOutlet weak var alarmEnabledSwitch: UISwitch!
    
    // MARK: - Actions

    @IBAction func didToggleAlarmEnabledSwitch(_ sender: UISwitch) {
        guard let alarm = alarm else { return }
        delegate?.didToggleEnabled(for: alarm)
    }
    
    // MARK: - Helpers
    
    func updateView(with alarm: Alarm) {
        alarmTitleLabel.text = alarm.title
        alarmFireDateLabel.text = alarm.fireDate!.toString()
        alarmEnabledSwitch.isOn = alarm.enabled
    }
    
}
