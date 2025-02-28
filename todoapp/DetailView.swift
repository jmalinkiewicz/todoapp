//
//  DetailView.swift
//  todoapp
//
//  Created by Jakub Malinkiewicz on 28/02/2025.
//

import SwiftUI

struct DetailView: View {
    let task: Task
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(task.title)
                .font(.title)
                .bold()
            Text(task.description)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        Spacer()
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Text("Edit")
                    }
                }
            }
    }
}

#Preview {
    NavigationStack {
        DetailView(task: Task(title: "Zakupy", description: "Mleko, jajka, mąka, woda, oliwa"))
    }
}
