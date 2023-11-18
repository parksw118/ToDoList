//
//  ToDoListView.swift
//  ToDoList
//
//  Created by 박상우 on 11/15/23.
//

import SwiftUI

struct ToDoListView: View {
    @Binding var toDo: ToDo

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(toDo.title)
                    .font(.headline)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.black)
                Text(toDo.description)
                    .font(.subheadline)
            }
            Spacer()

            Button(action: {
                toDo.completed.toggle()
            }) {
                Image(systemName: toDo.completed ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(toDo.completed ? .green : .gray)
                    .imageScale(.large)
            }
        }
    }
}

