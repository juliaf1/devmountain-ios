//
//  TaskController.swift
//  Task
//
//  Created by Julia Frederico on 24/10/22.
//

import Foundation

class TaskController {
    
    // MARK: - Properties and Shared Instance
    
    static let shared = TaskController()
    
    var tasks = [Task]()
    
    // MARK: - CRUD
    
    func createTask(title: String, deadline: Date) {
        let task = Task(title: title, deadline: deadline)
        tasks.append(task)
    }
    
    func completeTask(_ task: Task) {
        task.completed = true
    }
    
    func deleteTask(_ task: Task) {
        guard let index = tasks.firstIndex(of: task) else { return }
        tasks.remove(at: index)
    }
    
}
