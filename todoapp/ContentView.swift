//
//  ContentView.swift
//  todoapp
//
//  Created by Jakub Malinkiewicz on 28/02/2025.
//

import SwiftUI

struct ContentView: View {
    @Environment(TaskViewModel.self) private var viewModel: TaskViewModel
    @State private var showAddTaskView: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(sortedTasks) { task in
                    TaskRowView(task: task)
                }            }
            .navigationTitle("To do")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showAddTaskView.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddTaskView) {
                CreateTaskForm(displayForm: $showAddTaskView)
            }
        }
        
    }
    
    private var sortedTasks: [Task] {
        viewModel.tasks.sorted { $0.pinned && !$1.pinned }
    }
}

#Preview {
    ContentView()
        .environment(TaskViewModel())
}
