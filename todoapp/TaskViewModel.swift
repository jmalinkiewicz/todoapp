//
//  TaskViewModel.swift
//  todoapp
//
//  Created by Jakub Malinkiewicz on 28/02/2025.
//

import SwiftUI

@Observable class TaskViewModel {
   var tasks = [Task]()
    
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
}

