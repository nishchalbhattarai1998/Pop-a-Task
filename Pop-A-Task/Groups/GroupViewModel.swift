//
//  GroupViewModel.swift
//  Pop-A-Task
//
//  Created by Sangam Gurung on 2023-02-14.
//

import Foundation
import FirebaseFirestore

class GroupViewModel: ObservableObject {
    private let db = Firestore.firestore()
    private let groupsCollectionRef = Firestore.firestore().collection("groups")

    @Published var listData: [Groups] = []
    @Published var searchTerm = ""
    @Published var navTitle = "Groups"
    
    private var filteredData: [Groups] = []
    private var listenerRegistration: ListenerRegistration?
    
    init() {
        loadData()
    }
    
    private func loadData() {
        listenerRegistration = groupsCollectionRef.addSnapshotListener { querySnapshot, error in
            if let querySnapshot = querySnapshot {
                self.listData = querySnapshot.documents.compactMap { document in
                    try? document.data(as: Groups.self)
                }
            }
        }
    }
    
    func addGroup(name: String, description: String, members: [String], createBy: String) {
        let group = Groups(name: name, description: description, members: members, createDate: Date(), createBy: createBy)
        do {
            _ = try groupsCollectionRef.addDocument(from: group)
        } catch {
            print(error)
        }
    }
    
//    func deleteGroup(at index: Int) {
//        let group = listData[index]
//        if let documentId = group.id {
//            groupsCollectionRef.document(documentId).delete()
//        }
//    }
    func deleteGroup(at offsets: IndexSet) {
        for index in offsets {
            let group = listData[index]
            if let documentId = group.id {
                groupsCollectionRef.document(documentId).delete()
            }
        }
    }

    func resetData() {
        for group in listData {
            if let documentId = group.id {
                groupsCollectionRef.document(documentId).delete()
            }
        }
    }
    
    func moveGroup(from source: IndexSet, to destination: Int) {
        listData.move(fromOffsets: source, toOffset: destination)
        for i in 0..<listData.count {
            let group = listData[i]
            if let documentId = group.id {
                do {
                    try groupsCollectionRef.document(documentId).setData(from: group)
                } catch {
                    print(error)
                }
            }
        }
    }
    
    func filterSearchResults() {
        if searchTerm.isEmpty {
            filteredData = listData
        } else {
            filteredData = listData.filter { group in
                group.name.lowercased().contains(searchTerm.lowercased())
            }
        }
    }
    
    var displayCount: String {
        if searchTerm.isEmpty {
            return "\(listData.count) groups"
        } else {
            return "\(filteredData.count) of \(listData.count) groups"
        }
    }
    
    deinit {
        listenerRegistration?.remove()
    }
}

//
//final class GroupViewModel: ObservableObject {
//    let db = Firestore.firestore()
//    private var initialContact: [Groups] = Groups.mockGroups()
//
//    @ObservedObject var store: GroupStore
//    @Published var navTitle: String = ""
//    @Published var searchTerm: String = ""
//    @Published var searchResults: [Groups] = []
//
//
//
//
//    var listData: [Groups] {
//        return searchTerm.isEmpty ? store.groups : searchResults
//    }
//
//    var displayCount: String {
//        "\(listData.count) Groups"
//    }
//
//    init(store: GroupStore = GroupStore(), navTitle: String = "Groups") {
//        self.store = store
//        self.initialContact = GroupStore.mockGroups
//        self.navTitle = navTitle
//    }
//
////    init(store: GroupStore = GroupStore.testStore, navTitle: String = "Groups") {
////        self.store = store
////        self.initialContact = GroupStore.mockData
////        self.navTitle = navTitle
////
////    }
//    func addGroup(_ group: Groups) {
//        do {
//            let _ = try db.collection("groups").addDocument(from: group)
//            print("Group added successfully to Firestore")
//        } catch let error {
//            print("Error adding group to Firestore: \(error.localizedDescription)")
//        }
//    }
//
//
//    func filterSearchResults() {
//        searchResults = store.groups.filter({ $0.name.localizedCaseInsensitiveContains(searchTerm)})
//    }
//
//
//
//    func makeContact(contact: Groups) {
//        store.groups.append(contact)
//    }
//
//
//    func deleteContact(offsets: IndexSet) {
//        store.groups.remove(atOffsets: offsets)
//    }
//
//
//    func moveContacts(from: IndexSet, to: Int) {
//        store.groups.move(fromOffsets: from, toOffset: to)
//    }
//    func resetData(){
//        store.groups = initialContact
//    }
//}
//
//
//
//
//


//Letest Draft
//final class GroupViewModel: ObservableObject {
//    let db = Firestore.firestore()
//    @ObservedObject var store: GroupStore
//    @Published var navTitle: String = ""
//    @Published var searchTerm: String = ""
//    @Published var searchResults: [Groups] = []
//
//    private var initialGroup: [Groups]
//
//    var listData: [Groups] {
//        return searchTerm.isEmpty ? store.groups : searchResults
//    }
//
//    var displayCount: String {
//        "\(listData.count) Groups"
//    }
//
//    init(store: GroupStore = GroupStore(), navTitle: String = "Groups") {
//        self.store = store
//        self.initialGroup = GroupStore.testStore.groups
//        self.navTitle = navTitle
//    }
//
//
//
//    func filterSearchResults() {
//        searchResults = store.groups.filter({ $0.name.localizedCaseInsensitiveContains(searchTerm)})
//    }
//
////    func addGroup(contact: Groups) {
////        store.groups.append(contact)
////    }
//
//    func deleteGroup(offsets: IndexSet) {
//        store.groups.remove(atOffsets: offsets)
//    }
//
//    func moveGroup(from: IndexSet, to: Int) {
//        store.groups.move(fromOffsets: from, toOffset: to)
//    }
//
//    func resetData() {
//        store.groups = initialGroup
//    }
//}
