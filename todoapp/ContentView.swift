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
                ForEach(viewModel.tasks) { task in
                    NavigationLink(destination: DetailView(task: task)) {
                        CardView(task: task)
                    }
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            viewModel.removeTask(task)
                        } label: {
                            Image(systemName: "trash")
                        }
                    }

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
}

#Preview {
    ContentView()
        .environment(TaskViewModel())
}
