//
//  ContentView.swift
//  ToDo
//
//  Created by 박상우 on 11/12/23.
//

import SwiftUI

struct ToDo: Codable, Identifiable {
    var id: Int
    var title: String
    var description: String
    var completed: Bool
}

var toDoListData: [ToDo] = loadJson("Data.json")

class ToDoList: ObservableObject {
    @Published var ToDoLists: [ToDo]
    
    init(ToDoLists: [ToDo]) {
        self.ToDoLists = ToDoLists
    }
}

struct ContentView: View {
    @StateObject var toDoList: ToDoList = ToDoList(ToDoLists: toDoListData)
    @State private var stackPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $stackPath) {
            List {
                ForEach (0..<toDoList.ToDoLists.count, id: \.self) { i in
                    Button(action: {
                        toDoList.ToDoLists[i].completed.toggle()
                    }) {
                        ToDoListView(toDo: $toDoList.ToDoLists[i])
                    }
                }
                .onDelete(perform: deleteTask)
            }
            .padding(.bottom)
            .navigationDestination(for: String.self) { _ in
                AddToDo(toDoList: self.toDoList, path: $stackPath)
            }
            .navigationTitle("To Do List")
            .toolbar {
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                    NavigationLink(destination: AddToDo(toDoList: self.toDoList, path: $stackPath)) {
                        Text("Add")
                    }
                }
                
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                    EditButton()
                }
            }
        }
    }
    
    func deleteTask(at offsets: IndexSet) {
        toDoList.ToDoLists.remove(atOffsets: offsets)
    }
}


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


#Preview {
    ContentView()
}
