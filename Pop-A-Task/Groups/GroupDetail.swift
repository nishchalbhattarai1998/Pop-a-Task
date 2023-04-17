//  GroupDetail.swift
//  Pop-A-Task
//
//  Created by Sangam Gurung on 2023-02-14.
//

import Foundation
import SwiftUI
import FirebaseAuth

struct GroupDetail: View {
    @State private var isGroupModal = false
    @State private var isMemberModal = false
    @State private var isTaskModal = false
    @ObservedObject var userData: UserData
    let group: Groups
    @StateObject var viewModel = GroupViewModel()
    @StateObject var taskViewModel = TaskViewModel()
    @EnvironmentObject var groupViewModel: GroupViewModel
    @State var showAddMemberView = false
    @State private var showAlert = false
    @State private var showNoPermissionAlert = false
    @State private var memberNames: [String] = []
    
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }()
    
    var body: some View {
        //        NavigationView {
        //            VStack{
        List {
            Section(header: Text("Group Details")) {
                VStack(alignment: .leading) {
                    //                            VStack{
                    Text(group.description)
                        .font(.system(size: 15))
                        .font(.title)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    //                            }
                        .padding()
                    
                    Divider()
                    
                    HStack {
                        Text("Created By: \(group.createBy)")
                            .font(.footnote)
                            .fontWeight(.light)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.leading)
                        
                        Spacer()
                        Text(dateFormatter.string(from: group.createDate))
                            .font(.footnote)
                            .fontWeight(.light)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.trailing)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
            }
            .listRowInsets(EdgeInsets())
            
            Section(header: HStack {
                Text("Members")
                Spacer()
                Button("Add Member") {
                    isMemberModal = true
                }
                .foregroundColor(.blue)
                .sheet(isPresented: $isMemberModal) {
                    MemberModalView(isShowingModal: $isMemberModal, id: group.id ?? "not found")
                        .cornerRadius(20)
                }
            }) {
                ForEach(group.members, id: \.self) { member in
                    MemberRow(viewModel: viewModel, group: group, userID: member)
                }


                
            }
            .padding()
            .listRowInsets(EdgeInsets())
            
            Section(header: HStack {
                Text("Task")
                Spacer()
                NavigationLink(destination: AddTaskModalView(isTaskModal: .constant(true), task: Task())) {
                    Text("Add Task")
                }
            }) {
                // Display tasks
                ForEach(taskViewModel.filteredData.filter { $0.groupID == group.id }) { task in
                    Text(task.name)
                        .padding()
                }
            }
            .listRowInsets(EdgeInsets())
            .onAppear {
                taskViewModel.selectedGroupID = group.id
            }



            
            Button("Permanently Delete Group") {
                
                if
                    userData.userName! == group.createBy {
                    showAlert = true
                    print("showAlert: \(showAlert)")
                    print(userData.userName!)
                    print(group.createBy)
                }
                
            }
            
            
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Are you sure you want to delete this group?"), message: Text("All the tasks and activities conneced to this group will be also deleted. This action cannot be undone."), primaryButton: .destructive(Text("Delete")) {
                    print("Deleted")
                    viewModel.deleteGroup(group.id!)
                }, secondaryButton: .cancel())
            }
            .buttonStyle(.plain)
            .foregroundColor(.red)
            .padding(.leading, 50.0)
            .opacity(userData.userName != group.createBy ? 0.5 : 1.0) // Change opacity based on condition
            .disabled(userData.userName != group.createBy)
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(group.name)
        .environmentObject(viewModel)
        
    }
    
}

struct GroupDetail_Previews: PreviewProvider {
    static var previews: some View {
        if GroupStore.testStore.groups.count > 0 {
            return GroupDetail(userData: UserData(), group: GroupStore.testStore.groups[0])
        } else {
            return GroupDetail(userData: UserData(), group: Groups(name: "Default Group", description: "This is a default group.", members: ["Nischal", "Charles", "Harneet", "Manpreet","Sangam"], createDate: Date(), createBy: "System", groupID: ""))
        }
    }
}

struct MemberRow: View {
    @ObservedObject var viewModel: GroupViewModel
    let group: Groups
    let userID: String
    @State private var userName = ""
    @State private var showAlert = false

    var body: some View {
        HStack {
            Text(userName)
                .padding(.vertical, 8)
            
            Spacer()

            if viewModel.userData.userID == userID { // Current user
                if viewModel.userData.userName == group.createBy { // Current user is admin
                    Text("Admin")
//                        .padding(.trailing)
                        .foregroundColor(.red)
                } else { // Current user is not admin and can leave
                    Button(action: {
                        showAlert = true
                    }) {
                        Text("Leave")
                            .foregroundColor(.red)
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Leave group"),
                              message: Text("Are you sure you want to leave this group?"),
                              primaryButton: .destructive(Text("Leave")) {
                                  viewModel.removeMemberFromGroup(groupID: group.id!, memberID: userID)
                              },
                              secondaryButton: .cancel())
                    }
                }
            } else if viewModel.userData.userName == group.createBy { // Current user is admin, viewing other members
                if userName == group.createBy { // Other member is also admin
                    Text("Admin")
//                        .padding(.trailing)
                        .foregroundColor(.red)
                } else {
                    Button(action: {
                        showAlert = true
                    }) {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Remove member"),
                              message: Text("Are you sure you want to remove \(userName) from this group?"),
                              primaryButton: .destructive(Text("Remove")) {
                                  viewModel.removeMemberFromGroup(groupID: group.id!, memberID: userID)
                              },
                              secondaryButton: .cancel())
                    }
                }
            } else { // Current user is not admin, viewing other members
                if userName == group.createBy {
                    Text("Admin")
//                        .padding(.trailing)
                        .foregroundColor(.red)
                }
            }
        }
        .onAppear {
            viewModel.fetchUserName(by: userID) { fetchedUserName in
                userName = fetchedUserName
            }
        }
    }
}

