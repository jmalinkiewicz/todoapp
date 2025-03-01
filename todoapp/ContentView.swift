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
                            .contextMenu {
                                Button {
                                    viewModel.toggleTaskCompletion(task)
                                } label: {
                                    Label(task.completed ? "Mark undone" : "Mark done", systemImage: task.completed ? "checkmark.circle.badge.xmark" : "checkmark.circle")
                                }

                                Button(role: .destructive) {
                                    viewModel.removeTask(task)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                    }
                    .swipeActions(edge: .trailing) {
                        Button {
                            viewModel.toggleTaskCompletion(task)
                        } label: {
                            Image(systemName: task.completed ? "checkmark.circle.badge.xmark.fill" : "checkmark.circle.fill")
                        }
                        .tint(task.completed ? .yellow : .green)
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
