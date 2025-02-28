//
//  CreateTaskForm.swift
//  todoapp
//
//  Created by Jakub Malinkiewicz on 28/02/2025.
//

import SwiftUI

struct CreateTaskForm: View {
    @Environment(TaskViewModel.self) private var viewModel
    
    @Binding var displayForm: Bool
    
    @State private var taskTitle: String = ""
    @State private var taskDescription: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Task details")) {
                    TextField("Title", text: $taskTitle)
                    TextField("Description", text: $taskDescription)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(role: .destructive) {
                        displayForm = false
                    } label: {
                        Text("Cancel")
                            .foregroundStyle(.red)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.addTask(title: taskTitle, description: taskDescription)
                        displayForm = false
                    } label: {
                        Text("Create")
                            .bold()
                    }
                }
            }
            .navigationTitle("Create Task")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    @Previewable @State var displayForm = true
    NavigationStack {
        CreateTaskForm(displayForm: $displayForm)
            .environment(TaskViewModel())
    }
}
