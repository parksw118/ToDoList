//
//  AddToDo.swift
//  ToDoList
//
//  Created by 박상우 on 11/14/23.
//

import SwiftUI

struct AddToDo: View {
    @StateObject var toDoList: ToDoList
    @Binding var path: NavigationPath

    @State private var title: String = ""
    @State private var description: String = ""
    @State private var completed: Bool = false

    @State private var showAlert: Bool = false

    var body: some View {
        Form {
            Section{
                DataInput(title: "title", userInput: $title)
                DataInput(title: "description", userInput: $description)
            } header: {
                Text("To Do 추가")
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("ToDo 추가됨"),
                message: Text("새로운 ToDo가 추가되었습니다."),
                dismissButton: .default(Text("확인"))
            )
        }
        Button(action: {
            addToDo()
        }, label: {
            Text("To Do 추가")
        })
        .padding()

    }

    func addToDo() {
        let newToDo = ToDo(id: toDoList.ToDoLists.count, title: title, description: description, completed: false)
        toDoList.ToDoLists.append(newToDo)

        showAlert = true
//        path.removeLast()
    }
}

struct DataInput: View {
    var title: String
    @Binding var userInput: String

    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
            TextField("\(title) 입력", text: $userInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .padding()
    }
}


//
//#Preview {
//    AddToDo()
//}
