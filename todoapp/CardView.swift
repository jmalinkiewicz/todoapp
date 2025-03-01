//
//  CardView.swift
//  todoapp
//
//  Created by Jakub Malinkiewicz on 28/02/2025.
//

import SwiftUI

struct CardView: View {
    @Environment(TaskViewModel.self) private var viewModel
    let task: Task
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: task.completed ? "checkmark" : "circle")
                .frame(width: 20, height: 20)
                .foregroundStyle(.blue)
                .onTapGesture {
                    viewModel.toggleTaskCompletion(task)
                }
            VStack(alignment: .leading) {
                Text(task.title)
                    .font(.system(.title3))
                    .bold()
                HStack {
                    Text(task.description)
                        .lineLimit(1)
                    Spacer()
                    if task.pinned {
                        Image(systemName: "pin.fill")
                            .foregroundStyle(.blue)
                    }
                }
            }
        }
    }
}

#Preview {
    CardView(task: Task(title: "Zakupy", description: "Mleko, jajka, mąka, woda, oliwa"))
        .environment(TaskViewModel())
}
