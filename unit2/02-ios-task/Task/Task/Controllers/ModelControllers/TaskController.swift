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
    
    func create(taskWithTitle title: String, deadline: Date) {
        let task = Task(title: title, deadline: deadline)
        tasks.append(task)
    }
    
    func complete(_ task: Task) {
        task.completed = true
    }
    
    func delete(_ task: Task) {
        guard let index = tasks.firstIndex(of: task) else { return }
        tasks.remove(at: index)
    }
    
    // MARK: - Persistence Methods
    
    func loadFromStorage() {
        let jd = JSONDecoder()
        
        do {
            let data = try Data(contentsOf: fileURL())
            self.tasks = try jd.decode([Task].self, from: data)
        } catch let error {
            print(error)
        }
    }
    
    func saveToStorage() {
        let je = JSONEncoder()
        
        do {
            let data = try je.encode(tasks)
            try data.write(to: fileURL())
        } catch let error {
            print(error)
        }
    }

    private func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectoryURL = urls[0].appendingPathComponent("Tasks.json")
        return documentsDirectoryURL
    }
}
