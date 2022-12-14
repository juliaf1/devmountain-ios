//
//  EventController.swift
//  EventManager
//
//  Created by Julia Frederico on 09/11/22.
//

import CoreData

enum EventSections: Int {
    case attending
    case notAttending
    
    var title: String {
        switch self {
        case .attending:
            return "Attending Events"
        case .notAttending:
            return "Not Attending Events"
        }
    }
}

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
        fetchEvents()
    }
    
    // MARK: - CRUD
    
    func fetchEvents() {
        let events = (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
        attendingEvents = events.filter { $0.attending }
        notAttendingEvents = events.filter { !$0.attending }
    }
    
    func create(eventWithName name: String, date: Date) {
        let event = Event(name: name, date: date)
        attendingEvents.append(event)
        sortEvents()
        CoreDataStack.saveContext()
    }
    
    func delete(event: Event) {
        if let index = attendingEvents.firstIndex(of: event) {
            attendingEvents.remove(at: index)
        } else if let index = notAttendingEvents.firstIndex(of: event) {
            notAttendingEvents.remove(at: index)
        }
        sortEvents()
        CoreDataStack.context.delete(event)
        CoreDataStack.saveContext()
    }
    
    func update(event: Event, name: String, date: Date) {
        event.name = name
        event.date = date
        CoreDataStack.saveContext()
    }
    
    func toggleAttendance(of event: Event) {
        if let index = attendingEvents.firstIndex(of: event) {
            attendingEvents.remove(at: index)
            notAttendingEvents.append(event)
        } else if let index = notAttendingEvents.firstIndex(of: event) {
            notAttendingEvents.remove(at: index)
            attendingEvents.append(event)
        }
        event.attending = !event.attending
        sortEvents()
        CoreDataStack.saveContext()
    }
    
    // MARK: - Helpers
    
    func sortEvents() {
        attendingEvents.sort { $0.date! > $1.date! }
        notAttendingEvents.sort { $0.date! > $1.date! }
    }
    
}
