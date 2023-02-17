//
//  GroupViewModel.swift
//  Pop-A-Task
//
//  Created by Sangam Gurung on 2023-02-14.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class GroupViewModel: ObservableObject {
    
    private let db = Firestore.firestore()
    private var listenerRegistration: ListenerRegistration?
    
    @Published var listData = [Groups]()
    @Published var filteredData = [Groups]()
    @Published var searchTerm = ""
    @Published var navTitle = "Groups"
    
    init() {
        fetchGroups()
    }
    
    func fetchGroups() {
        listenerRegistration = db.collection("groups")
            .order(by: "name")
            .addSnapshotListener { (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                self.listData = querySnapshot.documents.compactMap { document in
                    do {
                        let group = try document.data(as: Groups.self)
                        return group
                    } catch {
                        print(error)
                    }
                    return nil
                }
                self.filterSearchResults()
            }
        }
    }
    
    func addGroup(_ group: Groups) {
        do {
            let _ = try db.collection("groups").addDocument(from: group)
        }
        catch {
            fatalError("Unable to encode group: \(error.localizedDescription).")
        }
    }
    
    func updateGroup(_ group: Groups) {
        if let groupID = group.id {
            do {
                try db.collection("groups").document(groupID).setData(from: group)
            }
            catch {
                fatalError("Unable to encode group: \(error.localizedDescription).")
            }
        }
    }
    
    func deleteGroup(at offsets: IndexSet) {
        let groupIDs = offsets.map { listData[$0].id! }
        for id in groupIDs {
            db.collection("groups").document(id).delete()
        }
    }
    
    func deleteGroup2(_ documentID: String) {
        let docRef = db.collection("groups").document(documentID)
        docRef.delete { error in
            if let error = error {
                print("Error deleting group: \(error.localizedDescription)")
            } else {
                print("Group successfully deleted")
            }
        }
    }

    func moveGroup(from: IndexSet, to: Int) {
        listData.move(fromOffsets: from, toOffset: to)
        for i in 0..<listData.count {
            let id = listData[i].id!
            db.collection("groups").document(id).updateData(["order": i])
        }
    }
    
    func resetData() {
        let batch = db.batch()
        for i in 0..<listData.count {
            let groupRef = db.collection("groups").document(listData[i].id!)
            batch.updateData(["order": i], forDocument: groupRef)
        }
        batch.commit() { error in
            if let error = error {
                print("Error updating document: \(error)")
            } else {
                print("Batch update succeeded")
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
        if filteredData.count == listData.count {
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
//import Foundation
//import FirebaseFirestore
//
//class GroupViewModel: ObservableObject {
//    private let db = Firestore.firestore()
//    private let groupsCollectionRef = Firestore.firestore().collection("groups")
//
//    @Published var listData: [Groups] = []
//    @Published var searchTerm = ""
//    @Published var navTitle = "Groups"
//
//    @Published var filteredData: [Groups] = []
//    private var listenerRegistration: ListenerRegistration?
//
//    init() {
//        loadData()
//    }
//
//    private func loadData() {
//        listenerRegistration = groupsCollectionRef.addSnapshotListener { querySnapshot, error in
//            if let querySnapshot = querySnapshot {
//                self.listData = querySnapshot.documents.compactMap { document in
//                    try? document.data(as: Groups.self)
//                }
//            }
//        }
//    }
//
//    func addGroup(name: String, description: String, members: [String], createBy: String) {
//        let group = Groups(name: name, description: description, members: members, createDate: Date(), createBy: createBy)
//        do {
//            _ = try groupsCollectionRef.addDocument(from: group)
//        } catch {
//            print(error)
//        }
//    }
//
////    func deleteGroup(at index: Int) {
////        let group = listData[index]
////        if let documentId = group.id {
////            groupsCollectionRef.document(documentId).delete()
////        }
////    }
//    func deleteGroup(at offsets: IndexSet) {
//        for index in offsets {
//            let group = listData[index]
//            if let documentId = group.id {
//                groupsCollectionRef.document(documentId).delete()
//            }
//        }
//    }
//
////    func resetData() {
////        for group in listData {
////            if let documentId = group.id {
////                groupsCollectionRef.document(documentId).delete()
////            }
////        }
////    }
//
//    func moveGroup(from source: IndexSet, to destination: Int) {
//        listData.move(fromOffsets: source, toOffset: destination)
//        for i in 0..<listData.count {
//            let group = listData[i]
//            if let documentId = group.id {
//                do {
//                    try groupsCollectionRef.document(documentId).setData(from: group)
//                } catch {
//                    print(error)
//                }
//            }
//        }
//    }
//
//    func filterSearchResults() {
//        if searchTerm.isEmpty {
//            filteredData = listData
//        } else {
//            filteredData = listData.filter { group in
//                group.name.lowercased().contains(searchTerm.lowercased())
//            }
//        }
//    }
//
//    var displayCount: String {
//        if searchTerm.isEmpty {
//            return "\(listData.count) groups"
//        } else {
//            return "\(filteredData.count) of \(listData.count) groups"
//        }
//    }
//
//    deinit {
//        listenerRegistration?.remove()
//    }
//}
