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
                    Text(task.title)
                }
            }
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
