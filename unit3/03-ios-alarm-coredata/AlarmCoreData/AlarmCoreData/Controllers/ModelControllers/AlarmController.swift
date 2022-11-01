//
//  AlarmController.swift
//  AlarmCoreData
//
//  Created by Julia Frederico on 01/11/22.
//

import CoreData

class AlarmController {
    
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
    
    func createAlarm(withTitle title: String, fireDate: Date, enabled: Bool) {}
    
    func update(_ alarm: Alarm, title: String, fireDate: Date, enabled: Bool) {}
    
    func delete(_ alarm: Alarm) {}
    
    func toggleEnabled(for alarm: Alarm) {}
    
}
