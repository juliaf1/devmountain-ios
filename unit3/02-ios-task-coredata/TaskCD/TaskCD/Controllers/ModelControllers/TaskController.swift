//
//  TaskController.swift
//  TaskCD
//
//  Created by Julia Frederico on 31/10/22.
//

import CoreData

class TaskController {
    
    // MARK: - Properties and shared instance
    
    static let shared = TaskController()
    
    var completedTasks: [Task] = []
    var incompleteTasks: [Task] = []
    
    private init() {
        fetchTasks()
    }
    
    private lazy var fetchRequest: NSFetchRequest<Task> = {
        let request = NSFetchRequest<Task>(entityName: Strings.taskEntityName)
        request.predicate = NSPredicate(value: true)
        return request
    }()
    
    // MARK: - CRUD
    
    func fetchTasks() {
        let tasks = (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
        
        completedTasks = tasks.filter { task in task.completed }
        incompleteTasks = tasks.filter { task in !task.completed }
    }
    
    func createTask(name: String, notes: String?, dueDate: Date?) {
        let task = Task(name: name, notes: notes, dueDate: dueDate)
        incompleteTasks.append(task)
    }
    
    func update(_ task: Task, name: String, notes: String?, dueDate: Date?) {
        task.name = name
        task.notes = notes
        task.dueDate = dueDate
    }
    
    func delete(_ task: Task) {
        if let index = completedTasks.firstIndex(of: task) {
            completedTasks.remove(at: index)
        } else if let index = incompleteTasks.firstIndex(of: task) {
            incompleteTasks.remove(at: index)
        }
    }
    
    func toggleCompleted(for task: Task) {
        task.completed = !task.completed
    }
    
}
