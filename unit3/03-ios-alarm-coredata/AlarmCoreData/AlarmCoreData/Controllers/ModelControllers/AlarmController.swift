//
//  AlarmController.swift
//  AlarmCoreData
//
//  Created by Julia Frederico on 01/11/22.
//

import CoreData

class AlarmController: AlarmScheduler {
    
    // MARK: - Properties and shared instance
    
    static let shared = AlarmController()
    
    private init() {
        fetchAlarms()
    }
    
    var alarms: [Alarm] = []
    
    private lazy var fetchRequest: NSFetchRequest<Alarm> = {
        let request = NSFetchRequest<Alarm>(entityName: Strings.alarmEntityName)
        request.predicate = NSPredicate(value: true)
        return request
    }()
    
    // MARK: - CRUD
    
    func fetchAlarms() {
        alarms = (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
    }
    
    func createAlarm(withTitle title: String, fireDate: Date, enabled: Bool) {
        let alarm = Alarm(title: title, fireDate: fireDate, enabled: enabled)
        alarms.append(alarm)
        CoreDataStack.saveContext()

        if enabled { scheduleUserNotifications(for: alarm) }
    }
    
    func update(_ alarm: Alarm, title: String, fireDate: Date, enabled: Bool) {
        alarm.title = title
        alarm.fireDate = fireDate
        alarm.enabled = enabled
        CoreDataStack.saveContext()
        
        cancelUserNotifications(for: alarm)
        if enabled { scheduleUserNotifications(for: alarm) }
    }
    
    func delete(_ alarm: Alarm) {
        guard let index = alarms.firstIndex(of: alarm) else { return }
        alarms.remove(at: index)
        CoreDataStack.context.delete(alarm)
        CoreDataStack.saveContext()

        cancelUserNotifications(for: alarm)
    }
    
    func toggleEnabled(for alarm: Alarm) {
        alarm.enabled = !alarm.enabled
        CoreDataStack.saveContext()

        if alarm.enabled {
            scheduleUserNotifications(for: alarm)
        } else {
            cancelUserNotifications(for: alarm)
        }
    }
    
}
