//
//  CardView.swift
//  todoapp
//
//  Created by Jakub Malinkiewicz on 28/02/2025.
//

import SwiftUI

struct CardView: View {
    let task: Task
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: task.completed ? "checkmark" : "circle")
                .foregroundStyle(.blue)
            VStack(alignment: .leading) {
                Text(task.title)
                    .font(.system(.title3))
                    .bold()
                Text(task.description)
            }
        }
    }
}

#Preview {
    CardView(task: Task(title: "Zakupy", description: "Mleko, jajka, mąka, woda, oliwa"))
}
