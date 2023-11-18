//
//  ContentView.swift
//  ToDoList
//
//  Created by 박상우 on 11/14/23.
//

import SwiftUI

// Data.json 파일을 읽어오기만 하므로 Decodable만 사용.
struct ToDo: Decodable {
    var id: Int
    var title: String
    var description: String
    var completed: Bool
}

var toDoListData: [ToDo] = loadJson("Data.json")

class ToDoList: ObservableObject {
    @Published var toDoLists: [ToDo]

    init(toDoLists: [ToDo]) {
        self.toDoLists = toDoLists
    }
}

struct ContentView: View {
    @StateObject var toDoList: ToDoList = ToDoList(toDoLists: toDoListData)

    var body: some View {
        NavigationStack() {
            List {
                ForEach (0..<toDoList.toDoLists.count, id: \.self) { i in
                    Button(action: {
                        toDoList.toDoLists[i].completed.toggle()
                    }) {
                        ToDoListView(toDo: $toDoList.toDoLists[i])
                    }
                }
                .onDelete(perform: deleteTask)
            }
            .padding(.bottom)
            .navigationDestination(for: String.self) { _ in
                AddToDo(toDoList: self.toDoList)
            }
            .navigationTitle("To Do List")
            .toolbar {
                
                ToolbarItem(placement: .topBarLeading) {
                    NavigationLink(destination: AddToDo(toDoList: self.toDoList)) {
                        Text("Add")
                    }
                }
                ToolbarItem(placement: .topBarTrailing ) {
                    EditButton()
                }
            }
        }
    }

    func deleteTask(at offsets: IndexSet) {
        toDoList.toDoLists.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
