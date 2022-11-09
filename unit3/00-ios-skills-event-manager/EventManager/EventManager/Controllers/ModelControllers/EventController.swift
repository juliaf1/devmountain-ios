//
//  EventController.swift
//  EventManager
//
//  Created by Julia Frederico on 09/11/22.
//

import CoreData

class EventController {
    
    // MARK: - Properties
    
    static let shared = EventController()
    
    var attendingEvents: [Event] = []
    var notAttendingEvents: [Event] = []
    
    private lazy var fetchRequest: NSFetchRequest<Event> = {
        let request = NSFetchRequest<Event>(entityName: Strings.eventEntityName)
        request.predicate = NSPredicate(value: true)
        return request
    }()
    
    // MARK: - Initializer
    
    private init() {
        fetchAlarms()
    }
    
    // MARK: - CRUD
    
    func fetchAlarms() {
        let events = (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
        attendingEvents = events.filter { $0.attending }
        notAttendingEvents = events.filter { !$0.attending }
    }
    
}
