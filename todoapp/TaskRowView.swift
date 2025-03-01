//
//  TaskRowView.swift
//  todoapp
//
//  Created by Jakub Malinkiewicz on 01/03/2025.
//

import SwiftUI

struct TaskRowView: View {
    @Environment(TaskViewModel.self) private var viewModel: TaskViewModel
    let task: Task
    
    var body: some View {
        NavigationLink(destination: DetailView(task: task)) {
            CardView(task: task)
        }
        .contextMenu { contextMenu }
        .swipeActions(edge: .trailing) { trailingSwipeActions }
        .swipeActions(edge: .leading) { leadingSwipeActions }
    }
    
    // MARK: - Context Menu
    private var contextMenu: some View {
        Group {
            Button {
                withAnimation {
                    viewModel.toggleTaskPin(task)
                }
            } label: {
                Label(task.pinned ? "Unpin" : "Pin", systemImage: task.pinned ? "pin.slash" : "pin")
            }
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
    
    // MARK: - Swipe Actions
    private var trailingSwipeActions: some View {
        Group {
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
    }

    private var leadingSwipeActions: some View {
        Button {
            withAnimation {
                viewModel.toggleTaskPin(task)
            }
        } label: {
            Image(systemName: task.pinned ? "pin.slash.fill" : "pin.fill")
        }
        .tint(.blue)
    }
}

#Preview {
    TaskRowView(task: Task(title: "Zakupy", description: "Jajka, mleko, woda"))
        .environment(TaskViewModel())
}
