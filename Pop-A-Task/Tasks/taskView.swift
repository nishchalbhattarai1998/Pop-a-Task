
//  taskView.swift
//  Pop-A-Task
//
//  Created by nishchal bhattarai on 2023-02-06.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore


struct taskView: View {
    @State private var isTaskModal = false
    @State private var isTaskSetting = false
    @State private var showMenu = false
    @ObservedObject var userData = UserData()
    @Binding var categories: [String]
    @Binding var status: [String]
    @Binding var priority: [String]
    
    @State private var searchText = ""
    @State private var tasks = [Task]()
    private let taskViewModel = TaskViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                List(tasks.filter {
                    searchText.isEmpty ? true : $0.name.localizedCaseInsensitiveContains(searchText)
                }) { task in
                    TaskRow(task: task)
                }
                .searchable(text: $searchText)
                .onAppear {
                    taskViewModel.fetchTasks { fetchedTasks in
                        self.tasks = fetchedTasks
                    }
                }
                .toolbar {
                    HStack {
                        Button("Add Task") {
                            isTaskModal = true
                        }
                        .sheet(isPresented: $isTaskModal) {
                            AddTaskModalView(isTaskModal: $isTaskModal)
                        }
                        
                        Button("Task Setting") {
                            isTaskSetting = true
                        }
                        .sheet(isPresented: $isTaskSetting) {
                            TaskSettingsModal(isTaskSetting: $isTaskSetting)
                        }
                    }
                }
            }
            .navigationTitle("Tasks")
        }
    }
}

struct taskView_Previews: PreviewProvider {
    static var previews: some View {
        taskView(categories: .constant(["Category1", "Category2", "Category3"]),
                 status: .constant(["Status1", "Status2", "Status3"]),
                 priority: .constant(["Priority1", "Priority2", "Priority3"]))
    }
}


