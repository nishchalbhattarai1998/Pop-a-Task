
//need update in the database. delaying for the next spring
// Completed the delayed task
import SwiftUI

struct AddTaskModalView: View {
    @ObservedObject private var categoryViewModel = CategoryViewModel()
    @ObservedObject private var priorityViewModel = PriorityViewModel()
    @ObservedObject private var statusViewModel = StatusViewModel()
    @ObservedObject var groupViewModel = GroupViewModel()
    @ObservedObject var taskViewModel = TaskViewModel()
    @ObservedObject var userData = UserData()
    @ObservedObject var userViewModel = UserViewModel()
    @Binding var isTaskModal: Bool
    @State var taskName = ""
    @State var description = ""
//    private var usersInSelectedGroup: [User] {
//        guard let selectedGroupID = groupViewModel.getGroupID(groupName: selectedGroup) else { return [] }
//        return userViewModel.users.filter { $0.groupID.keys.contains(selectedGroupID) }
//    }
    @State private var selectedAssignee: String = UserViewModel().users.first?.name ?? "None"
    @State private var selectedCategory: String = CategoryViewModel().cListData.first?.name ?? "No Category"
    @State private var selectedStatus: String = StatusViewModel().sListData.first?.name ?? "No Status"
    @State private var selectedPriority: String = PriorityViewModel().pListData.first?.name ?? "No Priority"
    @State private var selectedGroup: String = GroupViewModel().filteredData.first?.name ?? "None"


    
    
//    init(isTaskModal: Binding<Bool>) {
//        self._isTaskModal = isTaskModal
//        _selectedCategory = State(initialValue: CategoryViewModel().cListData.first?.name ?? "No Category")
//        _selectedStatus = State(initialValue: StatusViewModel().sListData.first?.name ?? "No Status")
//        _selectedPriority = State(initialValue: PriorityViewModel().pListData.first?.name ?? "No Priority")
//        _selectedAssignee = State(initialValue: "None") // Initialize selectedAssignee to the first user in the list
//        _selectedGroup = State(initialValue: GroupViewModel().filteredData.first?.name ?? "None")
//    }


    
    @State var selectedDate = Date()
    @State private var isDatePickerVisible = false
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    var body: some View {
//        let usersInSpecificGroup = userViewModel.usersInGroup(groupID: "some_group_id")
        ScrollView{
            
            Text("Add Task").font(.largeTitle).padding(.top, 30)
            TextField("Name of the task", text: $taskName)
                .padding(20)
                .background(Color(hue: 0.345, saturation: 0.095, brightness: 0.952).cornerRadius(15.0))
            
            HStack {
                Text("Category:")
                Menu {
                    ForEach(categoryViewModel.cListData, id: \.id) { category in
                        Button(action: { self.selectedCategory = category.name }) {
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
            
            HStack {
                Text("Status:")
                Menu {
                    ForEach(statusViewModel.sListData, id: \.id) { status in
                        Button(action: { self.selectedStatus = status.name }) {
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
                Text("priority:")
                Menu {
                    ForEach(priorityViewModel.pListData, id: \.id) { priority in
                        Button(action: { self.selectedPriority = priority.name }) {
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
            
            VStack {
                
                DatePicker(selection: $selectedDate, displayedComponents: .date) {
                    Text("Deadline:")
                }
                .padding()
            }
            HStack {
                Text("Groups:")
                Menu {
                    ForEach(groupViewModel.filteredData) { group in
                        Button(action: { self.selectedGroup = group.name }) {
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
            
            HStack {
                Text("Assignee:")
                Menu {
                    ForEach(userViewModel.users) { user in
                        Button(action: { self.selectedAssignee = user.name }) {
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





            
            
            VStack{
                Text(" Enter Description about the task below:")
                    .padding()
                TextEditor(text: $description)
                    .cornerRadius(15.0)
                    .padding(10)
                    .background(Color(hue: 0.345, saturation: 0.095, brightness: 0.952).cornerRadius(15.0))
                    .frame(height: 200.0)
            }
            HStack {
                Button("Cancel") {
                    isTaskModal = false
                }
                .padding(.horizontal)
                .frame(width: 150.0, height: 50.0)
                .background(Color.red)
                .foregroundColor(Color.white)
                .cornerRadius(15.0)
                Button("Add Task") {
                    createTask()
                    isTaskModal = false    }
                .padding(.horizontal)
                .frame(width: 150.0, height: 50.0)
                .background(Color.green)
                .foregroundColor(Color.white)
                .cornerRadius(15.0)
                
            }
            
        }.padding()
        
    }
    
    func createTask() {
        // Get the selected group's ID
        let selectedGroupID = groupViewModel.getGroupID(groupName: selectedGroup)

        var newTask = Task(id: nil, name: taskName,
                           description: description,
                           category: selectedCategory,
                           status: selectedStatus,
                           priority: selectedPriority,
                           assignee: selectedAssignee,
                           group: selectedGroup,
                           groupID: selectedGroupID, // Pass the selected group's ID
                           deadline: selectedDate,
                           createdBy: userData.userName,
                           createdAt: Date(),
                           taskID: "")
        do {
            let taskRef = try taskViewModel.db.collection("tasks").addDocument(from: newTask)
            let taskID = taskRef.documentID
            newTask.id = taskID
            let _ = try taskRef.setData(from: newTask)
            print("Task added successfully to Firestore")
        } catch let error {
            print("Error adding task to Firestore: \(error.localizedDescription)")
        }
    }

}
    



struct AddTaskModalView_Preview: PreviewProvider {
    static var previews: some View {
        AddTaskModalView(isTaskModal: .constant(true))
    }
}


