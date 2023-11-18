//
//  AddToDo.swift
//  ToDoList
//
//  Created by 박상우 on 11/14/23.
//

import SwiftUI

struct AddToDo: View {
    @StateObject var toDoList: ToDoList
    
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var completed: Bool = false
    
    @State private var showAlert: Bool = false
    
    var body: some View {
        VStack {
            TitleInput(title: "TASK", userInput: $title)
            DescriptionInput(title: "MEMO", userInput: $description)
            HStack {
                Spacer()
                Button(action: {
                    addToDo()
                }, label: {
                    Text("ADD")
                })
                .buttonStyle(.borderedProminent)
                .padding()
                Spacer()
            }
            Spacer()
        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("ToDo 추가됨"),
                message: Text("새로운 ToDo가 추가되었습니다."),
                dismissButton: .default(Text("확인"))
            )
        }
    }
    
    func addToDo() {
        let newToDo = ToDo(id: toDoList.toDoLists.count, title: title, description: description, completed: false)
        toDoList.toDoLists.append(newToDo)
        
        showAlert = true
    }
}

struct TitleInput: View {
    var title: String
    @Binding var userInput: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
            TextField("할 일을 입력하세요.", text: $userInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .padding()
    }
}

struct DescriptionInput: View {
    var title: String
    @Binding var userInput: String
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $userInput)
                        .frame(height: 200)
                        .font(.body)
                        .padding(8)
                    
                    if userInput.isEmpty {
                        Text("메모를 입력하세요.")
                            .foregroundColor(Color(UIColor.placeholderText))
                            .padding(.horizontal, 13)
                            .padding(.top, 17)
                    }
                }
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 0.3))
                .background(Color.white)
                .cornerRadius(8)
            }
            .padding()
        }
    }
}



//#Preview {
//    AddToDo()
//}
