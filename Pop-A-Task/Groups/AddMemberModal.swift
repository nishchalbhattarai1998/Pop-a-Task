//
//  AddMemberModal.swift
//  Pop-A-Task
//
//  Created by Neetay layal on 2023-02-18.
//


import Foundation
import SwiftUI
import FirebaseFirestore

struct MemberModalView: View {
    @Binding var isShowingModal: Bool
    @State var searchTerm = ""
    @State var groupName = ""
    @State var description = ""

    @ObservedObject var userData = UserData()
    let db = Firestore.firestore()
    var body: some View {
        NavigationView {
            List{

                Text("No members found")
                    .frame(maxWidth: .infinity,  alignment: .center)
            }
            .navigationTitle("Add Members")
            .searchable(text: $searchTerm,
                        placement: .navigationBarDrawer(displayMode: .automatic),
                        prompt: "Search for users")
            .onChange(of: searchTerm) { newValue in
                filterSearchResults()
            }
            
            .toolbar {
                HStack {
                    EditButton()
                    Button("Cancel"){
                        
                        isShowingModal = false
                    }
                }
            }
        }.animation(.default, value: searchTerm)
    }
    
    func addGroup() {
        let group = Groups(name: groupName, description: description, members: [], createDate: Date(), createBy: userData.userName!)
        do {
            let _ = try db.collection("groups").addDocument(from: group)
            print("Group added successfully to Firestore")
        } catch let error {
            print("Error adding group to Firestore: \(error.localizedDescription)")
        }
    }
    
    func filterSearchResults() {
        if searchTerm.isEmpty {
//            filteredData = listData
        } else {
//            filteredData = listData.filter { group in
//                group.name.lowercased().contains(searchTerm.lowercased())
            }
        }
    }

    struct MemberModalView_Previews: PreviewProvider {
        static var previews: some View {
            MemberModalView(isShowingModal: .constant(true))
        }
    }



