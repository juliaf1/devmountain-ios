//
//  AlarmTableViewCell.swift
//  AlarmCoreData
//
//  Created by Julia Frederico on 01/11/22.
//

import UIKit

class AlarmTableViewCell: UITableViewCell {

    // MARK: - Properties and outlets
    
    var alarm: Alarm?
    
    @IBOutlet weak var alarmTitleLabel: UILabel!
    @IBOutlet weak var alarmFireDateLabel: UILabel!
    @IBOutlet weak var alarmEnabledSwitch: UISwitch!
    
    // MARK: - Actions

    @IBAction func didToggleAlarmEnabledSwitch(_ sender: UISwitch) {
    }
    
}
