

import Foundation
import SwiftUI
import FirebaseFirestore
import Firebase

struct taskView: View {
    @ObservedObject var viewModel = TaskViewModel()
    @ObservedObject var userData = UserData()
    @State private var isShowingModal = false
    let db = Firestore.firestore()
//    let group = Groups

    
    var body: some View {
        NavigationView {
            List {
//                let userID = userData.userID
                    ForEach(viewModel.filteredData) { task in
                        TaskRow(task: task)
                    }
//                    .onMove(perform: moveTask)
//                    .onDelete(perform: deletGroup)
                    //                .frame(width: 350.0)
                HStack {
                    Spacer()
                    Text(viewModel.displayCount)
                        .foregroundColor(.green)
                    
                    Spacer()
                }
            }
            .id(viewModel.listData) // observe the viewModel's listData property
            .navigationTitle(viewModel.navTitle)
            .backgroundStyle(.gray)
//            .cornerRadius(15)
            .searchable(text: $viewModel.searchTerm,
                        placement: .navigationBarDrawer(displayMode: .automatic),
                        prompt: "Search for tasks")
            .onChange(of: viewModel.searchTerm) { newValue in
                viewModel.filterSearchResults()
            }
            .animation(.default, value: viewModel.searchTerm)

            // Toolbar: Add and Edit
            .toolbar {
                HStack {
                    Button("Add"){
                        isShowingModal = true
                        
                    }.sheet(isPresented: $isShowingModal) {
                        AddTaskModalView(isTaskModal: $isShowingModal, task: Task(id: "1", name: "Test Task",
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
                                                                                  taskID:"1"))
                            .cornerRadius(20)
//                            .padding(50)
//                            .shadow(radius: 20)
//                            .background(Color.gray)
                    }
                        Spacer()
                        EditButton()
//                        Button("Reset", action: resetData)
                    
                }
            }
        }
    }
    
//    func resetData() {
//        viewModel.resetData()
//    }
    
    func moveGroup(from: IndexSet, to: Int) {
        withAnimation {
            viewModel.moveTask(from: from, to: to)
        }
    }
    
//    func deletGroup(offsets: IndexSet) {
//        withAnimation {
//            viewModel.deleteGroup(at: offsets)
//        }
//    }

}

struct taskVIew_Previews: PreviewProvider {
    static var previews: some View {
        taskView(viewModel: TaskViewModel())
    }
}
