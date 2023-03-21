//
//  AddSettingTaskModal.swift
//  Pop-A-Task
//
//  Created by Sangam Gurung on 2023-02-19.
//
// add category completed
//we need to store everything to the db
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

enum ActiveSheet: Identifiable {
    case addCategory, addPriority, addStatus

    var id: Int {
        switch self {
        case .addCategory:
            return 1
        case .addPriority:
            return 2
        case .addStatus:
            return 3
        }
    }
}

struct TaskSettingsModal: View {
    @Binding var isTaskSetting: Bool
    @ObservedObject private var categoryViewModel = CategoryViewModel()
    @ObservedObject private var priorityViewModel = PriorityViewModel()
    @ObservedObject private var statusViewModel = StatusViewModel()

    // State variables to track whether to show the Add Item views
    @State var activeSheet: ActiveSheet?
    @State private var isAddingCategory = false
    @State private var isAddingPriority = false
    @State private var isAddingStatus = false

    var body: some View {
        NavigationView {
            List {
                Section(header: HStack {
                    Text("Category")
                    Spacer()
                    Button("Add") {
                        isAddingCategory.toggle()
                        activeSheet = .addCategory
                    }
                }) {
                    ForEach(categoryViewModel.cListData) { category in
                        HStack {
                            Text(category.name)
                            Spacer()
                        }.padding()
                    }
                }
                .listRowInsets(EdgeInsets())
                
                Section(header: HStack {
                    Text("Priority")
                    Spacer()
                    Button("Add") {
                        isAddingPriority.toggle()
                        activeSheet = .addPriority
                    }
                }) {
                    ForEach(priorityViewModel.pListData) { priority in
                        HStack {
                            Text(priority.name)
                            Spacer()
                        }.padding()
                    }
                }
                .listRowInsets(EdgeInsets())
                
                Section(header: HStack {
                    Text("Status")
                    Spacer()
                    Button("Add") {
                        isAddingStatus.toggle()
                        activeSheet = .addStatus
                    }
                }) {
                    ForEach(statusViewModel.sListData) { status in
                        HStack {
                            Text(status.name)
                            Spacer()
                        }.padding()
                    }
                }
                .listRowInsets(EdgeInsets())
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Task Settings")
            .padding(.vertical, 10)
            .background(Color.gray.opacity(0.1))
            .sheet(item: $activeSheet) { item in
                switch item {
                case .addCategory:
                    AddCategoryView(isAddingCategory: $isAddingCategory, categoryViewModel: categoryViewModel, activeSheet: $activeSheet)
                case .addPriority:
                    AddPriorityView(isAddingPriority: $isAddingPriority, priorityViewModel: priorityViewModel, activeSheet: $activeSheet)
                case .addStatus:
                    AddStatusView(isAddingStatus: $isAddingStatus, statusViewModel: statusViewModel, activeSheet: $activeSheet)
                }

            }
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
    @ObservedObject var categoryViewModel: CategoryViewModel
    @Binding var activeSheet: ActiveSheet?
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
            .navigationBarItems(leading: backButton)
            .navigationBarItems(trailing: saveButton)
            .overlay(messageView)
        }
    }
    private var backButton: some View {
        Button("Back") {
            activeSheet = nil
        }
    }

    private var saveButton: some View {
        Group {
            if !newCategory.isEmpty {
                Button("Save") {
                    let categories = Category(id: nil, name: newCategory, tasks: [], createBy: "", categoryID: "")
                    categoryViewModel.addCategory(categories)
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
    @ObservedObject var priorityViewModel: PriorityViewModel
    @Binding var activeSheet: ActiveSheet?
    @State private var newPriority: String = ""
    @State private var showMessage = false

    var body: some View {
        NavigationView {
            VStack {
                TextField("New priority", text: $newPriority)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Spacer()
            }
            .navigationBarTitle("Add Priority", displayMode: .inline)
            .navigationBarItems(leading: backButton)
            .navigationBarItems(trailing: saveButton)
            .overlay(messageView)
        }
    }
    private var backButton: some View {
        Button("Back") {
            activeSheet = nil
        }
    }

    private var saveButton: some View {
        Group {
            if !newPriority.isEmpty {
                Button("Save") {
                    let priorities = Priority(id: nil, name: newPriority, tasks: [], createBy: "", priorityID: "")
                    priorityViewModel.addPriority(priorities)
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
    @ObservedObject var statusViewModel: StatusViewModel
    @Binding var activeSheet: ActiveSheet?
    @State private var newStatus: String = ""
    @State private var showMessage = false

    var body: some View {
        NavigationView {
            VStack {
                TextField("New Status", text: $newStatus)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Spacer()
            }
            .navigationBarTitle("Add Status", displayMode: .inline)
            .navigationBarItems(leading: backButton)
            .navigationBarItems(trailing: saveButton)
            .overlay(messageView)
        }
    }
    private var backButton: some View {
        Button("Back") {
            activeSheet = nil
        }
    }

    private var saveButton: some View {
        Group {
            if !newStatus.isEmpty {
                Button("Save") {
                    let status = Status(id: nil, name: newStatus, tasks: [], createBy: "", statusID: "")
                    statusViewModel.addStatus(status)
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
