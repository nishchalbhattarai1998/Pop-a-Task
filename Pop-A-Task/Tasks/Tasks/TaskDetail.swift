import Foundation
import SwiftUI

struct TaskDetail: View {
    @ObservedObject var userData = UserData()
    @ObservedObject var taskViewModel = TaskViewModel()
    let task: Task
    @State private var comment: String = ""
    @ObservedObject var commentStore: CommentStore
    @State private var taskName: String
    @State private var taskDescription: String
    @State private var showAlert = false
    
    // Add the following properties
    @ObservedObject var categoryViewModel: CategoryViewModel
    @State private var selectedCategory: String
    // Add properties for the StatusViewModel and selectedStatus
    @ObservedObject var statusViewModel: StatusViewModel
    @State private var selectedStatus: String
    // Add properties for the PriorityViewModel and selectedPriority
    @ObservedObject var priorityViewModel: PriorityViewModel
    @State private var selectedPriority: String
    // Add properties for the selectedDate
    @State private var selectedDate: Date
    // Add properties for the selectedGroup
    @ObservedObject var groupViewModel: GroupViewModel
    @State private var selectedGroup: String
    
    // Add properties for the selectedAssignee
    @ObservedObject var userViewModel: UserViewModel
    @State private var selectedAssignee: String
    
    init(task: Task, taskViewModel: TaskViewModel, categoryViewModel: CategoryViewModel, statusViewModel: StatusViewModel, priorityViewModel: PriorityViewModel, groupViewModel: GroupViewModel, userViewModel: UserViewModel)  {
        self.task = task
        self.taskViewModel = taskViewModel
        self.groupViewModel = groupViewModel
        self.userViewModel = userViewModel
        self.commentStore = CommentStore(taskID: task.id ?? "")
        self._taskName = State(initialValue: task.name)
        self._taskDescription = State(initialValue: task.description ?? "")
        
        // Initialize the new properties
        self.categoryViewModel = categoryViewModel
        self._selectedCategory = State(initialValue: task.category ?? "")
        
        // Initialize the properties for Status
        self.statusViewModel = statusViewModel
        self._selectedStatus = State(initialValue: task.status ?? "")

        // Initialize the properties for Priority
        self.priorityViewModel = priorityViewModel
        self._selectedPriority = State(initialValue: task.priority ?? "")
        
        // Initialize the properties for selectedDate
        self._selectedDate = State(initialValue: task.deadline ?? Date())
        
        
        // Initialize the properties for selectedGroup
        self._selectedGroup = State(initialValue: task.group ?? "")
        
        // Initialize the properties for selectedAssignee
                self._selectedAssignee = State(initialValue: task.assignee ?? "")
    }
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    var body: some View {
        List {
            Section(header: Text("Task Detail")) {
                VStack(alignment: .leading) {
                    TextField("Name", text: $taskName, onCommit: {
                        // Save updated task name
                        var updatedTask = task
                        updatedTask.name = taskName
                        taskViewModel.updateTask(updatedTask)
                    })
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                VStack(alignment: .leading) {
                    TextField("Description", text: $taskDescription, onCommit: {
                        // Save updated task description
                        var updatedTask = task
                        updatedTask.description = taskDescription
                        taskViewModel.updateTask(updatedTask)
                    })
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
            }
            
            Section(header: Text("Setting")) {
                // Replace the VStack for Category with the provided HStack
                
                HStack {
                    Text("Category:")
                    Menu {
                        ForEach(categoryViewModel.cListData, id: \.id) { category in
                            Button(action: {
                                self.selectedCategory = category.name
                                updateTaskCategory()
                            }) {
                                Text(category.name)
                            }
                            
                        }
                    } label: {
                        HStack {
                            Spacer()
                            Text(selectedCategory)
                            Image(systemName: "chevron.down")
                                .foregroundColor(.blue)
                        }
                    }
                    .menuStyle(DefaultMenuStyle())
                }
                .padding()
                
                // Keep the other VStacks for Status and Priority as they were
                HStack {
                    Text("Status:")
                    Menu {
                        ForEach(statusViewModel.sListData, id: \.id) { status in
                            Button(action: {
                                self.selectedStatus = status.name
                                updateTaskStatus()
                            }) {
                                Text(status.name)
                            }
                            
                        }
                    } label: {
                        HStack {
                            Spacer()
                            Text(selectedStatus)
                            Image(systemName: "chevron.down")
                                .foregroundColor(.blue)
                        }
                    }
                    .menuStyle(DefaultMenuStyle())
                }
                .padding()
                
                HStack {
                    Text("Priority:")
                    Menu {
                        ForEach(priorityViewModel.pListData, id: \.id) { priority in
                            Button(action: {
                                self.selectedPriority = priority.name
                                updateTaskPriority()
                            }) {
                                Text(priority.name)
                            }
                            
                        }
                    } label: {
                        HStack {
                            Spacer()
                            Text(selectedPriority)
                            Image(systemName: "chevron.down")
                                .foregroundColor(.blue)
                        }
                    }
                    .menuStyle(DefaultMenuStyle())
                }
                .padding()
            }
                
                Section(header: Text("Deadline")) {
                    VStack {
                        DatePicker("Deadline:", selection: $selectedDate, displayedComponents: .date)
                            .onChange(of: selectedDate) { newValue in
                                updateTaskDeadline()
                            }
                    }
                    .padding()
                }
            Section(header: Text("Group")) {
                HStack {
                    Text("Groups:")
                    Menu {
                        ForEach(groupViewModel.filteredData) { group in
                            Button(action: {
                                self.selectedGroup = group.name
                                updateTaskGroup()
                            }) {
                                Text(group.name)
                            }
                        }
                    } label: {
                        HStack {
                            Spacer()
                            Text(selectedGroup)
                            Image(systemName: "chevron.down")
                                .foregroundColor(.blue)
                        }
                    }
                    .menuStyle(DefaultMenuStyle())
                }
                .padding()
            }
            
            Section(header: Text("Assigned to")) {
                HStack {
                    Text("Assignee:")
                    Menu {
                        ForEach(userViewModel.users) { user in
                            Button(action: {
                                self.selectedAssignee = user.name
                                updateTaskAssignee()
                            }) {
                                Text(user.name)
                            }
                        }
                    } label: {
                        HStack {
                            Spacer()
                            Text(selectedAssignee)
                            Image(systemName: "chevron.down")
                                .foregroundColor(.blue)
                        }
                    }
                    .menuStyle(DefaultMenuStyle())
                }
                .padding()
            }
            
            Section(header: Text("Created")) {
                VStack(alignment: .leading) {
                    Text("By: \(task.createdBy ?? "")")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                }
                .padding()

                VStack(alignment: .leading) {
                    Text("At: \(dateFormatter.string(from: task.createdAt ?? Date()))")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                }
                .padding()
            }

            .frame(maxWidth: .infinity, alignment: .leading)
            
            Section(header: Text("Comments")) {
                ForEach(commentStore.comments) { comment in
                    ZStack {
                        VStack(alignment: .leading) {
                                Text(comment.comment)
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.leading)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding()
                        
                            Text("By: \(comment.commentedBy)")
                                .font(.caption2)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            if comment.commentedBy == userData.userName {


                                    Button(action: {
                                        // Delete the comment from the database
                                        commentStore.deleteComment(id: comment.id)
                                    }, label: {
                                        Text("Delete")
                                            .font(.caption)
                                            .foregroundColor(.red)
                                    })
                                    .buttonStyle(PlainButtonStyle())
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                        }
                    }
                    .padding()
                }
            }



            Section(header: Text("Add Comment")) {
                VStack(alignment: .leading) {
                    TextEditor(text: $comment)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, minHeight: 100, alignment: .leading)
                        .padding()
                }
                .background(Color.gray.opacity(0.1))
                .cornerRadius(15)
                .padding(.vertical)

                Button(action: {
                    // Add the new comment to the store
                    commentStore.addComment(comment: comment, commentedBy: userData.userName ?? "Unknown", taskID: task.id ?? "")


                    // Clear the comment text editor
                    comment = ""

                }, label: {
                    Text("Add Comment")
                })
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
            }
            
            Button("Permanently Delete Group") {
                
                if
                    userData.userName! == task.createdBy {
                    showAlert = true
                    print("showAlert: \(showAlert)")
                    print(userData.userName!)
                    print(task.createdBy ?? "No User Found")
                }
                
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Are you sure you want to delete this task?"), message: Text("All the data and activities conneced to this task will be also deleted. This action cannot be undone."), primaryButton: .destructive(Text("Delete")) {
                    print("Deleted")
                    taskViewModel.deletaTask(task.id!)
                }, secondaryButton: .cancel())
            }
            .buttonStyle(.plain)
            .foregroundColor(.red)
            .padding(.leading, 50.0)
            .opacity(userData.userName != task.createdBy ? 0.5 : 1.0) // Change opacity based on condition
            .disabled(userData.userName != task.createdBy)
            
        }
        
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(task.name)
    }
    private func updateTaskCategory() {
        var updatedTask = task
        updatedTask.category = selectedCategory
        taskViewModel.updateTask(updatedTask)
    }
    private func updateTaskStatus() {
        var updatedTask = task
        updatedTask.status = selectedStatus
        taskViewModel.updateTask(updatedTask)
    }
    private func updateTaskPriority() {
        var updatedTask = task
        updatedTask.priority = selectedPriority
        taskViewModel.updateTask(updatedTask)
    }
    func updateTaskDeadline() {
            guard let taskID = task.id else { return }
            taskViewModel.db.collection("tasks").document(taskID).updateData(["deadline": selectedDate]) { error in
                if let error = error {
                    print("Error updating task deadline: \(error.localizedDescription)")
                } else {
                    print("Task deadline updated successfully")
                }
            }
        }
    func updateTaskGroup() {
        guard let taskID = task.id else { return }
        taskViewModel.db.collection("tasks").document(taskID).updateData(["group": selectedGroup]) { error in
            if let error = error {
                print("Error updating task group: \(error.localizedDescription)")
            } else {
                print("Task group updated successfully")
            }
        }
    }
    func updateTaskAssignee() {
        guard let taskID = task.id else { return }
        taskViewModel.db.collection("tasks").document(taskID).updateData(["assignee": selectedAssignee]) { error in
            if let error = error {
                print("Error updating task assignee: \(error.localizedDescription)")
            } else {
                print("Task assignee updated successfully")
            }
        }
    }
}


struct TaskDetail_Preview: PreviewProvider {
    static var previews: some View {
        // Create instances of the required view models
        let taskViewModel = TaskViewModel()
        let categoryViewModel = CategoryViewModel()
        let statusViewModel = StatusViewModel()
        let priorityViewModel = PriorityViewModel()
        let groupViewModel = GroupViewModel()
        let userViewModel = UserViewModel()
        
        // Pass the view models as arguments when initializing the TaskDetail view
        TaskDetail(task: Task(id: "1", name: "Test Task",
                              description: "My Task Description",
                              category: "Test Category",
                              status: "Test Status",
                              priority: "Test Priority",
                              assignee: "Test assignee",
                              group: "Test Group",
                              groupID: "1",
                              deadline: Date(),
                              createdBy: "Charles Roy",
                              createdAt: Date(),
                              taskID: "1"),
                   taskViewModel: taskViewModel,
                   categoryViewModel: categoryViewModel,
                   statusViewModel: statusViewModel,
                   priorityViewModel: priorityViewModel,
                   groupViewModel: groupViewModel,
                   userViewModel: userViewModel)
    }
}

