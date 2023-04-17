
//
//  GroupModalView.swift
//  Pop-A-Task
//
//  Created by nishchal bhattarai on 2023-02-17.
// Task Completed

import SwiftUI
import FirebaseFirestore

struct ModalView: View {
    @Binding var isShowingModal: Bool
    @State var groupName = ""
    @State var description = ""
    @ObservedObject var userData = UserData()
    let db = Firestore.firestore()
    
    var body: some View {
        VStack {
            HStack {
                Text("Add Group")
                    .font(.largeTitle)
                    .padding(.leading, 35)
                Spacer()
                Button(action: {
                    isShowingModal = false
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundColor(.gray)
                        .padding()
                }
            }
            Divider()
            
            TextField("Name of the group", text: $groupName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Description", text: $description)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Divider()
            
            HStack{
                Button("Dismiss") {
                    isShowingModal = false
                }
                .padding()
                .frame(width: 150, height: 50.0, alignment: .center)
                .background(Color.green)
                .foregroundColor(Color.white)
                .cornerRadius(15.0)
                .padding()
                
                Button("Create") {
                    addGroup()
                    isShowingModal = false
                }
                .padding()
                .frame(width: 150.0, height: 50.0, alignment: .center)
                .background(Color.green)
                .foregroundColor(Color.white)
                .cornerRadius(15.0)
                .padding()
            }
        }
        .padding()
        
        .cornerRadius(20)
    }
    
    func addGroup() {
        var group = Groups(name: groupName, description: description, members: [userData.userID!], createDate: Date(), createBy: userData.userName ?? "", groupID: "")
        do {
            let groupRef = try db.collection("groups").addDocument(from: group)
            let groupID = groupRef.documentID
            group.groupID = groupID
            let _ = try groupRef.setData(from: group)
            let userRef = db.collection("users").document(userData.userID ?? "")
            userRef.updateData([
                "groupID": FieldValue.arrayUnion([groupID])
            ])
            print("Group added successfully to Firestore")
        } catch let error {
            print("Error adding group to Firestore: \(error.localizedDescription)")
        }
    }
}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView(isShowingModal: .constant(true))
    }
}
