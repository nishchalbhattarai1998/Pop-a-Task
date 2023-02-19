////
////  AddMemberModal.swift
////  Pop-A-Task
////
////  Created by Neetay layal on 2023-02-18.
////
//
//
//import Foundation
//import SwiftUI
//import FirebaseFirestore
//
//struct MemberModalView: View {
//    @Binding var isShowingModal: Bool
//    @State var searchTerm = ""
//    @State var groupName = ""
//    @State var description = ""
//
//    @ObservedObject var userData = UserData()
//    let db = Firestore.firestore()
//    var body: some View {
//        NavigationView {
//            List{
//
//                Text("No members found")
//                    .frame(maxWidth: .infinity,  alignment: .center)
//            }
//            .navigationTitle("Add Members")
//            .searchable(text: $searchTerm,
//                        placement: .navigationBarDrawer(displayMode: .automatic),
//                        prompt: "Search for users")
//            .onChange(of: searchTerm) { newValue in
//                filterSearchResults()
//            }
//
//            .toolbar {
//                HStack {
//                    EditButton()
//                    Button("Cancel"){
//
//                        isShowingModal = false
//                    }
//                }
//            }
//        }.animation(.default, value: searchTerm)
//    }
//
//    func addGroup() {
//        let group = Groups(name: groupName, description: description, members: [], createDate: Date(), createBy: userData.userName!)
//        do {
//            let _ = try db.collection("groups").addDocument(from: group)
//            print("Group added successfully to Firestore")
//        } catch let error {
//            print("Error adding group to Firestore: \(error.localizedDescription)")
//        }
//    }
//
//    func filterSearchResults() {
//        if searchTerm.isEmpty {
////            filteredData = listData
//        } else {
////            filteredData = listData.filter { group in
////                group.name.lowercased().contains(searchTerm.lowercased())
//            }
//        }
//    }
//
//    struct MemberModalView_Previews: PreviewProvider {
//        static var previews: some View {
//            MemberModalView(isShowingModal: .constant(true))
//        }
//    }
//
//
//
//
//  MemberModalView.swift
//  Pop-A-Task
//
//  Created by Neetay layal on 2023-02-18.
//
//
//  MemberModalView.swift
//  Pop-A-Task
//
//  Created by Neetay layal on 2023-02-18.
//

import SwiftUI
import FirebaseFirestore

struct MemberModalView: View {
    @Binding var isShowingModal: Bool
    @State var searchTerm = ""
    @State var groupName = ""
    @State var description = ""

    @ObservedObject var userData = UserData()
    let db = Firestore.firestore()
    @State var filteredUsers: [(id: String, name: String)] = []

    var body: some View {
        NavigationView {
            List {
                ForEach(filteredUsers, id: \.id) { user in
                    Button(user.name) {
                   
                    }
                }
                HStack{
                    Spacer()
                    if !filteredUsers.isEmpty {
                        Section {
                            Text("\(filteredUsers.count) user(s) found")
                                .foregroundColor(.gray)
                        }
                    } else {
                        Section {
                            Text("No users found")
                                .foregroundColor(.gray)
                        }
                    }
                    Spacer()
                }
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
                    Button("Cancel") {
                        isShowingModal = false
                    }
                }
            }
            .listRowBackground(Color(UIColor.systemBackground))
            .listStyle(GroupedListStyle())
            
            if !filteredUsers.isEmpty {
                Section {
                    Text("\(filteredUsers.count) search result(s)")
                }
            }
        }
            .animation(.default, value: searchTerm)

    }

    func filterSearchResults() {
        if searchTerm.isEmpty {
            filteredUsers = []
        } else {
            db.collection("users")
                .whereField("name", isGreaterThanOrEqualTo: searchTerm)
                .whereField("name", isLessThan: searchTerm + "~")
                .getDocuments { querySnapshot, error in
                    if let error = error {
                        print("Error getting search results: \(error.localizedDescription)")
                        //Demo Data for view preview can be removed
                        filteredUsers = [(id: "1", name: "John"), (id: "2", name: "Jane"), (id: "3", name: "Bob")]
                        //Demo Data
                    } else {
                        filteredUsers = querySnapshot?.documents.map {
                            (id: $0.documentID, name: $0.data()["name"] as? String ?? "")
                        } ?? []
                    }
                }
        }
    }
}

struct MemberModalView_Previews: PreviewProvider {
    static var previews: some View {
        MemberModalView(isShowingModal: .constant(true))
    }
}
