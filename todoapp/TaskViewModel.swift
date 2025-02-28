//
//  TaskViewModel.swift
//  todoapp
//
//  Created by Jakub Malinkiewicz on 28/02/2025.
//

import SwiftUI

@Observable class TaskViewModel {
    var tasks = [Task]() {
        didSet {
            saveTasks()
        }
    }
    
    init() {
        loadTasks()
    }
    
    func addTask(_ task: Task) {
        tasks.append(task)
    }
    
    func addTask(title: String, description: String) {
        addTask(Task(title: title, description: description))
    }
    
    func removeTask(at index: Int) {
        tasks.remove(at: index)
    }
    
    func removeAllTasks() {
        tasks.removeAll()
    }
    
    private func saveTasks() {
        if let encoded = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(encoded, forKey: "TodoTasks")
        }
    }

    private func loadTasks() {
        if let savedTasks = UserDefaults.standard.data(forKey: "TodoTasks") {
            if let decodedItems = try? JSONDecoder().decode([Task].self, from: savedTasks) {
                tasks = decodedItems
            }
        }
    }
}

