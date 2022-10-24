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

    var tasks = [Task(title: "clean up the plates", notes: nil, deadline: nil)] //[Task]()

    // MARK: - CRUD
    
    func create(taskWithTitle title: String, notes: String?, deadline: Date?) {
        let task = Task(title: title, notes: notes, deadline: deadline)
        tasks.append(task)
    }

    func update(_ task: Task, title: String, notes: String?, deadline: Date?) {
        task.title = title
        task.notes = notes
        task.deadline = deadline
    }
    
    func delete(_ task: Task) {
        guard let index = tasks.firstIndex(of: task) else { return }
        tasks.remove(at: index)
    }

    func toggleIsComplete(for task: Task) {
        task.completed = !task.completed
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
