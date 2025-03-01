//
//  DetailView.swift
//  todoapp
//
//  Created by Jakub Malinkiewicz on 28/02/2025.
//

import SwiftUI

struct DetailView: View {
    @Environment(TaskViewModel.self) private var viewModel: TaskViewModel
    @State private var isEditing = false
    @State private var editedTitle: String
    @State private var editedDescription: String
    
    let task: Task
    
    init(task: Task) {
        self.task = task
        _editedTitle = State(initialValue: task.title)
        _editedDescription = State(initialValue: task.description)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if isEditing {
                TextField("Title", text: $editedTitle)
                    .font(.title)
                    .bold()
                TextField("Description", text: $editedDescription)
            } else {
                Text(task.title)
                    .font(.title)
                    .bold()
                Text(task.description)
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(isEditing ? "Save" : "Edit") {
                    if isEditing {
                        viewModel.updateTask(task, title: editedTitle, description: editedDescription)
                    }
                    isEditing.toggle()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        DetailView(task: Task(title: "Zakupy", description: "Mleko, jajka, mąka, woda, oliwa"))
            .environment(TaskViewModel())
    }
}
