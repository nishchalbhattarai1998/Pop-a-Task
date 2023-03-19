//
//  AddSettingTaskModal.swift
//  Pop-A-Task
//
//  Created by Sangam Gurung on 2023-02-19.
//
// add category completed
//we need to store everything to the db
import Foundation
import SwiftUI

struct TaskSettingsModal: View {
    @Binding var isTaskSetting: Bool

    @ObservedObject private var taskSettingsModel = TaskSettingsModel()

    // State variables to track whether to show the Add Item views
    @State private var isAddingCategory = false
    @State private var isAddingStatus = false
    @State private var isAddingPriority = false

    var body: some View {
        NavigationView {
            List {
                Section(header: HStack {
                    Text("Category")
                    Spacer()
                    NavigationLink(destination: AddCategoryView(isAddingCategory: $isAddingCategory, taskSettingsModel: taskSettingsModel)) {
                        Text("Add")
                    }
                }) {
                    ForEach(taskSettingsModel.taskSettings.categories) { category in
                        HStack {
                            Text(category.name)
                            Spacer()
                        }.padding()
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            let item = taskSettingsModel.taskSettings.categories[index]
                            taskSettingsModel.deleteItem(item: item, itemType: "categories", completion: {_ in })
                        }
                    }

                }
                .listRowInsets(EdgeInsets())

                Section(header: HStack {
                    Text("Status")
                    Spacer()
                    NavigationLink(destination: AddStatusView(isAddingStatus: $isAddingStatus, taskSettingsModel: taskSettingsModel)) {
                        Text("Add")
                    }
                }) {
                    ForEach(taskSettingsModel.taskSettings.status) { status in
                        HStack {
                            Text(status.name)
                            Spacer()
                        }.padding()
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            let item = taskSettingsModel.taskSettings.status[index]
                            taskSettingsModel.deleteItem(item: item, itemType: "status", completion: {_ in })
                        }
                    }
                }
                .listRowInsets(EdgeInsets())

                Section(header: HStack {
                    Text("Priority")
                    Spacer()
                    NavigationLink(destination: AddPriorityView(isAddingPriority: $isAddingPriority, taskSettingsModel: taskSettingsModel)) {
                        Text("Add")
                    }
                }) {
                    ForEach(taskSettingsModel.taskSettings.priority) { priority in
                        HStack {
                            Text(priority.name)
                            Spacer()
                        }.padding()
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            let item = taskSettingsModel.taskSettings.priority[index]
                            taskSettingsModel.deleteItem(item: item, itemType: "priority", completion: {_ in })
                        }
                    }
                }
                .listRowInsets(EdgeInsets())

            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Task Settings")
            .padding(.vertical, 10)
            .background(Color.gray.opacity(0.1))
        }
    }
}

struct TaskSettingsModal_Preview: PreviewProvider {
    static var previews: some View {
        TaskSettingsModal(isTaskSetting: .constant(true))
    }
}



struct AddCategoryView: View {
    @Binding var isAddingCategory: Bool
    @ObservedObject var taskSettingsModel: TaskSettingsModel

    @State private var newCategory: String = ""
    @State private var showMessage = false

    var body: some View {
        NavigationView {
            VStack {
                TextField("New category", text: $newCategory)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Spacer()
            }
            .navigationBarTitle("Add Category", displayMode: .inline)
            .navigationBarItems(trailing: saveButton)
            .overlay(messageView)
        }
    }
    
    private var saveButton: some View {
        Group {
            if !newCategory.isEmpty {
                Button("Save") {
                    let category = Category(taskId: "", name: newCategory)
                    taskSettingsModel.addItem(item: category, itemType: "categories", completion: {_ in })
                    isAddingCategory = false
                    newCategory = ""
                    showMessage = true
                    
                    // Hide the message after 1 second
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                        showMessage = false
                    }
                }
            } else {
                EmptyView()
            }
        }
    }

    private var messageView: some View {
        Group {
            if showMessage {
                Text("Category added!")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(8)
                    .transition(.opacity)
            }
        }
    }
}

struct AddPriorityView: View {
    @Binding var isAddingPriority: Bool
    @ObservedObject var taskSettingsModel: TaskSettingsModel

    @State private var newPriority: String = ""
    @State private var showMessage = false

    var body: some View {
        NavigationView {
            VStack {
                TextField("New Priority", text: $newPriority)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Spacer()
            }
            .navigationBarTitle("Add Priority", displayMode: .inline)
            .navigationBarItems(trailing: saveButton)
            .overlay(messageView)
        }
    }
    
    private var saveButton: some View {
        Group {
            if !newPriority.isEmpty {
                Button("Save") {
                    let priority = Priority(taskId: "", name: newPriority)
                    taskSettingsModel.addItem(item: priority, itemType: "priority", completion: {_ in })
                    isAddingPriority = false
                    newPriority = ""
                    showMessage = true
                    
                    // Hide the message after 1 second
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                        showMessage = false
                    }
                }
            } else {
                EmptyView()
            }
        }
    }

    private var messageView: some View {
        Group {
            if showMessage {
                Text("Priority added!")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(8)
                    .transition(.opacity)
            }
        }
    }
}
struct AddStatusView: View {
    @Binding var isAddingStatus: Bool
    @ObservedObject var taskSettingsModel: TaskSettingsModel

    @State private var newStatus: String = ""
    @State private var showMessage = false

    var body: some View {
        NavigationView {
            VStack {
                TextField("New status", text: $newStatus)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Spacer()
            }
            .navigationBarTitle("Add Status", displayMode: .inline)
            .navigationBarItems(trailing: saveButton)
            .overlay(messageView)
        }
    }
    
    private var saveButton: some View {
        Group {
            if !newStatus.isEmpty {
                Button("Save") {
                    let status = Status(taskId: "", name: newStatus)
                    taskSettingsModel.addItem(item: status, itemType: "status", completion: {_ in })
                    isAddingStatus = false
                    newStatus = ""
                    showMessage = true
                    
                    // Hide the message after 1 second
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                        showMessage = false
                    }
                }
            } else {
                EmptyView()
            }
        }
    }

    private var messageView: some View {
        Group {
            if showMessage {
                Text("Status added!")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(8)
                    .transition(.opacity)
            }
        }
    }
}
