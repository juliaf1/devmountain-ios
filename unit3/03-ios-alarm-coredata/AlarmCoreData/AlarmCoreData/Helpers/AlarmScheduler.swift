//
//  AlarmScheduler.swift
//  AlarmCoreData
//
//  Created by Julia Frederico on 01/11/22.
//

import UserNotifications

protocol AlarmScheduler {
    func scheduleUserNotifications(for alarm: Alarm)
    func cancelUserNotifications(for alarm: Alarm)
}

extension AlarmScheduler {

    func scheduleUserNotifications(for alarm: Alarm) {
        let content = UNMutableNotificationContent()
        content.title = alarm.title!
        content.body = "Time to: \(alarm.title!) ⏰"
        
        let dateComponents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute], from: alarm.fireDate!)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let request = UNNotificationRequest(identifier: alarm.uuiString!, content: content, trigger: trigger)
    
        UNUserNotificationCenter.current().add(request)
    }

    func cancelUserNotifications(for alarm: Alarm) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarm.uuiString!])
    }

}
