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

    
    var body: some View {
        VStack {
            Text("Add Task").font(.largeTitle).padding(.top, 30)
            TextField("Name of the task", text: $taskName)
                .padding(20)
                .background(Color(hue: 0.345, saturation: 0.095, brightness: 0.952))
                .cornerRadius(15.0)
            HStack {
                Text("Category:").padding(.leading, 30)
                Menu {
                    ForEach(categories, id: \.self) { category in
                        Button(action: { self.selectedCategory = category }) {
                            Text(category)
                        }
                        
                    }
                } label: {
                    HStack {
                        Text(selectedCategory)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .foregroundColor(.blue)
                    }
                }
                .padding()
                .menuStyle(DefaultMenuStyle()) // Set the menu style to DefaultMenuStyle()
            }
            .padding()
            
            HStack {
                Text("Status:").padding(.leading, 30)
                Menu {
                    ForEach(status, id: \.self) { status in
                        Button(action: { self.selectedStatus = status }) {
                            Text(status)
                        }
                        
                    }
                } label: {
                    HStack {
                        Text(selectedStatus)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .foregroundColor(.blue)
                    }
                }
                .padding()
                .menuStyle(DefaultMenuStyle()) // Set the menu style to DefaultMenuStyle()
            }
            .padding()
            
            HStack {
                Text("priority:").padding(.leading, 30)
                Menu {
                    ForEach(priority, id: \.self) { priority in
                        Button(action: { self.selectedPriority = priority }) {
                            Text(priority)
                        }
                        
                    }
                } label: {
                    HStack {
                        Text(selectedPriority)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .foregroundColor(.blue)
                    }
                }
                .padding()
                .menuStyle(DefaultMenuStyle()) // Set the menu style to DefaultMenuStyle()
            }
            .padding()


            
            VStack{
                Text(" Enter Description about the task below:")
                    .padding()
                TextEditor(text: $description)
                                .cornerRadius(15.0)
                                .padding(10)
            }.background(Color.gray.opacity(0.1))
            HStack {
                Button("Cancel") {
                    isTaskModal = false
                }
                .padding()
                .frame(width: 150.0, height: 50.0)
                .background(Color.red)
                .foregroundColor(Color.white)
                .cornerRadius(15.0)
                Button("Create") {}
                    .padding()
                    .frame(width: 150.0, height: 50.0)
                    .background(Color.green)
                    .foregroundColor(Color.white)
                    .cornerRadius(15.0)
                
            }}}}
struct AddTaskModalView_Preview: PreviewProvider {
    static var previews: some View {
        AddTaskModalView(isTaskModal: .constant(true), categories: .constant(["Household", "Sports", "Grocery", "Utility"]), status: .constant(["To Do", "In Progress", "Done", "Cancelled"]), priority: .constant(["High", "Medium", "Low"]))
    }
}

