//
//  NotificationManager.swift
//  AlarmCoreData
//
//  Created by Julia Frederico on 01/11/22.
//

import UserNotifications

class NotificationManager: NSObject {
    
//    override init() {
//        super.init()
//        UNUserNotificationCenter.current().delegate = self
//    }

    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if !granted {
                print("Notification access has been denied", String(describing: error))
            }
        }
    }

}

//extension NotificationManager: UNUserNotificationCenterDelegate {
//    
//    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        print("gets here lol")
//        completionHandler([.banner, .badge, .sound])
//    }
//
//}
