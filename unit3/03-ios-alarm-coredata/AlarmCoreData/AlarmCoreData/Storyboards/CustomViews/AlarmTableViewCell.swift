//
//  AlarmTableViewCell.swift
//  AlarmCoreData
//
//  Created by Julia Frederico on 01/11/22.
//

import UIKit

protocol AlarmCellDelegate: AnyObject {
    func didToggleEnabled(for cell: AlarmTableViewCell)
}

class AlarmTableViewCell: UITableViewCell {

    // MARK: - Properties and outlets

    weak var delegate: AlarmCellDelegate?
    
    @IBOutlet weak var alarmTitleLabel: UILabel!
    @IBOutlet weak var alarmFireDateLabel: UILabel!
    @IBOutlet weak var alarmEnabledSwitch: UISwitch!
    
    // MARK: - Actions

    @IBAction func didToggleAlarmEnabledSwitch(_ sender: UISwitch) {
        delegate?.didToggleEnabled(for: self)
    }
    
    // MARK: - Helpers
    
    func updateView(with alarm: Alarm) {
        alarmTitleLabel.text = alarm.title
        alarmFireDateLabel.text = alarm.fireDate!.toString()
        alarmEnabledSwitch.isOn = alarm.enabled
    }
    
}
