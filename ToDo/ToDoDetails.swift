//
//  ToDoDetails.swift
//  ToDo
//
//  Created by 박상우 on 11/12/23.
//

import SwiftUI

struct ToDoDetails: View {
    let todo: ToDo
    
    var body: some View {
        Form {
            Section {
                Text(todo.title)
                    .font(.subheadline)
            } header: {
                Text("To Do")
            }
            
            Section {
                Text(todo.description)
                    .font(.subheadline)
            } header: {
                Text("상세 내용")
            }
            
        }
    }
}

#Preview {
    ToDoDetails(todo: toDoListData[0])
}
