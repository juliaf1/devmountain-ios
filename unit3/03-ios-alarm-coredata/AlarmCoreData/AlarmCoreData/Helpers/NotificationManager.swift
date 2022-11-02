//
//  NotificationManager.swift
//  AlarmCoreData
//
//  Created by Julia Frederico on 01/11/22.
//

import UserNotifications

class NotificationManager: NSObject {

    static func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if !granted {
                print("Notification access denied", String(describing: error))
            }
        }
    }

}

extension NotificationManager: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .badge, .sound])
    }

}
