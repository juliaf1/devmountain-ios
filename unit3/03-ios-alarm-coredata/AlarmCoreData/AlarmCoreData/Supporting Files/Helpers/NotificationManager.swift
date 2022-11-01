//
//  NotificationManager.swift
//  AlarmCoreData
//
//  Created by Julia Frederico on 01/11/22.
//

import UserNotifications

class NotificationManager: NSObject, UNUserNotificationCenterDelegate {
    
    override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }

    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if !granted {
                print("Notification access has been denied", String(describing: error))
            }
        }
    }

}
