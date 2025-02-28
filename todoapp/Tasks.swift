//
//  Tasks.swift
//  todoapp
//
//  Created by Jakub Malinkiewicz on 28/02/2025.
//

import Foundation

struct Tasks {
    var tasks = [Task]()
    
    struct Task {
        var id: UUID
        var title: String
        var description: String
    }
}
