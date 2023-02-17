//
//  GroupViewModel.swift
//  Pop-A-Task
//
//  Created by Sangam Gurung on 2023-02-14.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import Firebase
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
final class GroupViewModel: ObservableObject {
    let db = Firestore.firestore()
    @ObservedObject var store: GroupStore
    @Published var navTitle: String = ""
    @Published var searchTerm: String = ""
    @Published var searchResults: [Groups] = []
    
    private var initialContact: [Groups]
    
    var listData: [Groups] {
        return searchTerm.isEmpty ? store.groups : searchResults
    }
    
    var displayCount: String {
        "\(listData.count) Groups"
    }
    
    init(store: GroupStore = GroupStore(), navTitle: String = "Groups") {
        self.store = store
        self.initialContact = GroupStore.testStore.groups
        self.navTitle = navTitle
    }
    

    
    func filterSearchResults() {
        searchResults = store.groups.filter({ $0.name.localizedCaseInsensitiveContains(searchTerm)})
    }
    
    func makeContact(contact: Groups) {
        store.groups.append(contact)
    }
    
    func deleteContact(offsets: IndexSet) {
        store.groups.remove(atOffsets: offsets)
    }
    
    func moveContacts(from: IndexSet, to: Int) {
        store.groups.move(fromOffsets: from, toOffset: to)
    }
    
    func resetData() {
        store.groups = initialContact
    }
}
