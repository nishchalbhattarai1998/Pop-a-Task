import Foundation
import SwiftUI

struct AddTaskModalView: View {
    @Binding var isShowModal: Bool
    @State private var selectedTaskLevel = "In Progress"
    @State private var selectedAssignee = "Person 1"
    @State private var selectedTaskCategory = "High"
    @State var taskName = ""
    @State var description = ""
    
    let taskLevels = ["In Progress", "Done", "Cancel"]
    let assignees = ["Person 1", "Person 2", "Person 3"]
    let categories = ["High", "Medium", "Low"]
    
    var body: some View {
        VStack {
            Text("Add Task").font(.largeTitle).padding(.top, 30)
            Divider()
            TextField("Name of the task", text: $taskName)
                .background(Color(hue: 0.345, saturation: 0.095, brightness: 0.952))
                .cornerRadius(15.0)
                .padding()
                .frame(width: 350.0, height: 50.0)
                .background(Color(hue: 0.345, saturation: 0.095, brightness: 0.952))
                .cornerRadius(15.0)
                .padding(10)
            
            Divider()
            HStack {
                Text("Task level:").padding(.leading, 30)
                Picker("", selection: $selectedTaskLevel) {
                    ForEach(taskLevels, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.trailing, 30)
            }
            .padding(.vertical, 10)
            .background(Color.gray.opacity(0.1))
            HStack {
                Text("Assignee:").padding(.leading, 30)
                Picker("", selection: $selectedAssignee) {
                    ForEach(assignees, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.trailing, 30)
            }
            .padding(.vertical, 10)
            .background(Color.gray.opacity(0.1))
            HStack {
                Text("Category:").padding(.leading, 30)
                Picker("", selection: $selectedTaskCategory) {
                    ForEach(categories, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.trailing, 30)
            }
            .padding(.vertical, 10)
            .background(Color.gray.opacity(0.1))
            Divider()
            
            VStack{
                Text(" Enter Description about the task below:")
                TextEditor(text: $description)
                                .background(Color(hue: 0.345, saturation: 0.095, brightness: 0.952))
                                .cornerRadius(15.0)
                                .padding()
                                .frame(width: 350.0, height: 100.0)
                                .background(Color(hue: 0.345, saturation: 0.095, brightness: 0.952))
                                .cornerRadius(15.0)
                                .padding(10)
            }.background(Color.gray.opacity(0.1))
            HStack {
                Button("Cancel") {
                    isShowModal = false
                }
                .padding()
                .frame(width: 150.0, height: 50.0)
                .background(Color.green)
                .foregroundColor(Color.white)
                .cornerRadius(15.0)
                Spacer()
                Button("Create") {}
                    .padding()
                    .frame(width: 150.0, height: 50.0)
                    .background(Color.green)
                    .foregroundColor(Color.white)
                    .cornerRadius(15.0)
                
            }}}}
struct AddTaskModalView_Preview: PreviewProvider{
    static var previews: some View{
        AddTaskModalView(isShowModal: .constant(true))
    }
}
