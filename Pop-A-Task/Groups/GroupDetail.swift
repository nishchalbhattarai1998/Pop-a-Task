//
//  GroupDetail.swift
//  Pop-A-Task
//
//  Created by Sangam Gurung on 2023-02-14.
//
//
//  GroupDetail.swift
//  Pop-A-Task
//
//  Created by Sangam Gurung on 2023-02-14.
//

import Foundation
import SwiftUI


struct GroupDetail: View {
    @State private var isShowingModal = false
    let group: Groups
    @StateObject var viewModel = GroupViewModel()
    @EnvironmentObject var groupViewModel: GroupViewModel
    @State var showAddMemberView = false
    
    
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
                        isShowingModal = true
                    }.foregroundColor(.blue)
                        .sheet(isPresented: $isShowingModal) {
                            MemberModalView(isShowingModal: $isShowingModal)
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
                            
                        }.foregroundColor(.blue)
                        
                    }
                    
                    
                    
                    
                    
                }
                .listStyle(PlainListStyle())
                
                
                Button("Permanently Delete Group") {
                    viewModel.deleteGroup2(group.id!)
                }
                .buttonStyle(.plain)
                .foregroundColor(.white)
                .padding()
                .background(Color.red)
                .cornerRadius(50)
                
            }
            
        }
}

struct GroupDetail_Previews: PreviewProvider {
    static var previews: some View {
        if GroupStore.testStore.groups.count > 0 {
            return GroupDetail(group: GroupStore.testStore.groups[0])
        } else {
            return GroupDetail(group: Groups(name: "Default Group", description: "This is a default group.", members: ["Nischal", "Charles", "Harneet", "Manpreet","Sangam"], createDate: Date(), createBy: "System"))
        }
    }
}
