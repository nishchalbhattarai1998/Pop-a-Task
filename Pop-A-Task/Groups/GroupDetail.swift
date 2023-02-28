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
    @EnvironmentObject var groupViewModel: GroupViewModel
    @State var showAddMemberView = false
    @State private var showAlert = false
    @State private var showNoPermissionAlert = false
    
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }()
    
    var body: some View {
        VStack {
            Text(group.name)
                .font(.system(size: 20))
                .fontWeight(.semibold)
                .padding(.vertical, 15)
                .frame(height:25.0)
            
            
            
            List {
                Section(header: Text("Group Details")) {
                    VStack(alignment: .leading) {
                        Text(group.description)
                            .font(.system(size: 15))
                            .font(.title)
                            .multilineTextAlignment(.leading)
                            .padding(.bottom)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
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
                }
                
                HStack {
                    Text("Members")
                    Spacer()
                    Button("Add Member") {
                        isMemberModal = true
                    }.foregroundColor(.blue)
                        .sheet(isPresented: $isMemberModal) {
                            MemberModalView(isShowingModal: $isMemberModal, id: group.id ?? "not found")
                            .cornerRadius(20)
                    }
                }
                    VStack{
                        ForEach(group.members, id: \.self) { member in
                            Text(member)
                                .font(.subheadline)
                                .padding(.bottom, 1.0)
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                    }
                    
                    HStack {
                        Text("Task")
                        Spacer()
                        Button("Add Task") {
                            isTaskModal = true
                        }.sheet(isPresented: $isTaskModal){
//                            AddTaskModalView(isTaskModal: $isTaskModal)
                        }.foregroundColor(.blue)
                        
                    }
                    
                    
                    
                    
                    
                }
                .listStyle(PlainListStyle())
                
                
            Button("Permanently Delete Group") {

                if
                   userData.userName! == group.createBy {
                    // Show confirmation message and delete on user confirm
                    showAlert = true
                    print("showAlert: \(showAlert)")
                    print(userData.userName!)
                    print(group.createBy)
                }
//                else {
//                    // Show message that user does not have permission
//                    print("showAlert: \(showNoPermissionAlert)")
//                    showNoPermissionAlert = true
//
//                    print(userData.userName!)
//                    print(group.createBy)
//                }
            }

//            .alert(isPresented: $showNoPermissionAlert) {
//                Alert(title: Text("Permission Denied"), message: Text("You do not have permission to delete this group."), dismissButton: .default(Text("OK")))
//            }
            
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Are you sure you want to delete this group?"), message: Text("All the tasks and activities conneced to this group will be also deleted. This action cannot be undone."), primaryButton: .destructive(Text("Delete")) {
                    print("Deleted")
                    viewModel.deleteGroup(group.id!)
                }, secondaryButton: .cancel())
            }
            .buttonStyle(.plain)
            .foregroundColor(.white)
            .padding()
            .background(Color.red)
            .cornerRadius(50)
            .opacity(userData.userName != group.createBy ? 0.5 : 1.0) // Change opacity based on condition
            .disabled(userData.userName != group.createBy)
            
            }
            .environmentObject(viewModel)
//            .onAppear {
//                viewModel.group = group
//                viewModel.fetchUsers()
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
