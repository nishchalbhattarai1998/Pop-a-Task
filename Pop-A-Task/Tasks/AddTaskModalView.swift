
//need update in the database. delaying for the next spring
// cont..
import SwiftUI

struct AddTaskModalView: View {
    @Binding var isTaskModal: Bool
    @Binding var categories: [String]
    @Binding var status: [String]
    @Binding var priority: [String]
    @State private var selectedCategory = "Household"
    @State private var selectedStatus = "To Do"
    @State private var selectedPriority = "Medium"
    @State var taskName = ""
    @State var description = ""
    @State private var selectedAssignee = "None"
    var assignees: [String] = ["Nishchal", "Charles", "Sangam"]
    
    @State var selectedDate = Date()
    @State private var isDatePickerVisible = false
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    var body: some View {
        Form{
//            VStack {
                Text("Add Task").font(.largeTitle).padding(.top, 30)
                TextField("Name of the task", text: $taskName)
                    .padding(20)
                    .background(Color(hue: 0.345, saturation: 0.095, brightness: 0.952).cornerRadius(15.0))

            
                HStack {
                    Text("Category:")
                    Menu {
                        ForEach(categories, id: \.self) { category in
                            Button(action: { self.selectedCategory = category }) {
                                Text(category)
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
                    .menuStyle(DefaultMenuStyle()) // Set the menu style to DefaultMenuStyle()
                }
                .padding()
                
                HStack {
                    Text("Status:")
                    Menu {
                        ForEach(status, id: \.self) { status in
                            Button(action: { self.selectedStatus = status }) {
                                Text(status)
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
                    .menuStyle(DefaultMenuStyle()) // Set the menu style to DefaultMenuStyle()
                }
                .padding()
                
                HStack {
                    Text("priority:")
                    Menu {
                        ForEach(priority, id: \.self) { priority in
                            Button(action: { self.selectedPriority = priority }) {
                                Text(priority)
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
                    .menuStyle(DefaultMenuStyle()) // Set the menu style to DefaultMenuStyle()
                }
                .padding()
                
                VStack {
                    
                    DatePicker(selection: $selectedDate, displayedComponents: .date) {
                        Text("Deadline:")
                    }
                    .padding()
                }
                
                HStack {
                    Text("Assignee:")
                    Menu {
                        ForEach(assignees, id: \.self) { assignee in
                            Button(action: { self.selectedAssignee = assignee }) {
                                Text(assignee)
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
                    .menuStyle(DefaultMenuStyle()) // Set the menu style to DefaultMenuStyle()
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
//                HStack {
                    Button("Cancel") {
                        isTaskModal = false
                    }
                    .padding(.horizontal, 145)
//                    .frame(width: 150.0, height: 50.0)
//                    .background(Color.red)
                    .foregroundColor(Color.red)
                    .cornerRadius(15.0)
                    Button("Add Task") {}
                        .padding(.horizontal, 137)
//                        .frame(width: 150.0, height: 50.0)
//                        .background(Color.green)
                        .foregroundColor(Color.green)
                        .cornerRadius(15.0)
                    
//                }
            
        }
        
    }
    
}

//}
struct AddTaskModalView_Preview: PreviewProvider {
    static var previews: some View {
        AddTaskModalView(isTaskModal: .constant(true), categories: .constant(["Household", "Sports", "Grocery", "Utility"]), status: .constant(["To Do", "In Progress", "Done", "Cancelled"]), priority: .constant(["High", "Medium", "Low"]), assignees: ["Nishchal", "Charles", "Sangam"])
    }
}

