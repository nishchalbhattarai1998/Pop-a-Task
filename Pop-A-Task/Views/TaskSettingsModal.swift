//
//  AddSettingTaskModal.swift
//  Pop-A-Task
//
//  Created by Sangam Gurung on 2023-02-19.
//
// add category completed
import Foundation
import SwiftUI

struct TaskSettingsModal: View {
    @Binding var isTaskSetting: Bool
//
//
    @State  var categories: [String] = ["Household", "Sports", "Grocery", "Utility"]
    @State  var  status = ["To Do", "In Progress", "Done", "Cancelled"]
    @State  var  priority = ["High", "Medium", "Low"]
    
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
                    NavigationLink(destination: AddCategoryView(isAddingCategory: $isAddingCategory, categories: $categories)) {
                        Text("Add")
                    }
                }) {
                    ForEach(categories, id: \.self) { category in
                        HStack {
                            Text(category)
                            Spacer()
                        }.padding()
                    }
                    .onDelete { indexSet in
                        categories.remove(atOffsets: indexSet)
                    }
                }
                .listRowInsets(EdgeInsets())
                
                Section(header: HStack {
                    Text("Status")
                    Spacer()
                    NavigationLink(destination: AddStatusView(isAddingStatus: $isAddingStatus, status: $status)) {
                        Text("Add")
                    }
                }) {
                    ForEach(status, id: \.self) { status in
                        HStack {
                            Text(status)
                            Spacer()
                        }.padding()
                    }
                    .onDelete { indexSet in
                        status.remove(atOffsets: indexSet)
                    }
                }
                .listRowInsets(EdgeInsets())
                
                Section(header: HStack {
                    Text("Priority")
                    Spacer()
                    NavigationLink(destination: AddPriorityView(isAddingPriority: $isAddingPriority, priority: $priority)) {
                        Text("Add")
                    }
                }) {
                    ForEach(priority, id: \.self) { priority in
                        HStack {
                            Text(priority)
                            Spacer()
                        }.padding()
                    }
                    .onDelete { indexSet in
                        priority.remove(atOffsets: indexSet)
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
    @Binding var categories: [String]
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
                    categories.append(newCategory)
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
    @Binding var priority: [String]
    @State private var newpriority: String = ""
    @State private var showMessage = false

    var body: some View {
        NavigationView {
            VStack {
                TextField("New Priority", text: $newpriority)
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
            if !newpriority.isEmpty {
                Button("Save") {
                    priority.append(newpriority)
                    isAddingPriority = false
                    newpriority = ""
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
    @Binding var status: [String]
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
                    status.append(newStatus)
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


