//
//  Tasks.swift
//  todoapp
//
//  Created by Jakub Malinkiewicz on 28/02/2025.
//

import Foundation
 
struct Task: Identifiable, Codable, Equatable {
    var id: UUID
    var title: String
    var description: String
    var completed: Bool
    
    init(title: String, description: String) {
        id = UUID()
        self.title = title
        self.description = description
        self.completed = false
    }
}
