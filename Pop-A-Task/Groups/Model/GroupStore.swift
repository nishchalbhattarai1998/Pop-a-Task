//
//  GroupStore.swift
//  Pop-A-Task
//
//  Created by Sangam Gurung on 2023-02-14.
//

//import Foundation
//
//final class GroupStore : ObservableObject {
//    @Published var groups: [Groups]
//
//    init(groups: [Groups] = mockData) {
//        self.groups = groups
//    }
//}
//
//extension GroupStore {
//    static var mockData = [
//        Groups(groupName: "Home Group",
//                isFavorite: true),
//        Groups(groupName: "School Group",
//                isFavorite: false),
//        Groups(groupName: "Sports Group",
//                isFavorite: true),
//        Groups(groupName: "Other Group",
//                isFavorite: false),
//    ]
//
//    static var testStore: GroupStore = GroupStore(groups: mockData)
//}

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class GroupStore: ObservableObject {
    private let db = Firestore.firestore()
    private let groupsCollectionRef = Firestore.firestore().collection("groups")
    @Published var groups: [Groups] = []

    init() {
        loadData()
    }

    func loadData() {
        groupsCollectionRef.addSnapshotListener { querySnapshot, error in
            if let querySnapshot = querySnapshot {
                self.groups = querySnapshot.documents.compactMap { document in
                    try? document.data(as: Groups.self)
                }
            }
        }
    }

//    func addGroup(_ group: Groups) {
//        do {
//            let _ = try groupsCollectionRef.addDocument(from: group)
//        } catch {
//            print("Error adding group: \(error.localizedDescription)")
//        }
//    }
//
//    func deleteGroup(_ group: Groups) {
//        if let documentID = group.id {
//            groupsCollectionRef.document(documentID).delete { error in
//                if let error = error {
//                    print("Error deleting group: \(error.localizedDescription)")
//                }
//            }
//        }
//    }
//
//    func updateGroup(_ group: Groups) {
//        if let documentID = group.id {
//            do {
//                try groupsCollectionRef.document(documentID).setData(from: group)
//            } catch {
//                print("Error updating group: \(error.localizedDescription)")
//            }
//        }
//    }
}


extension GroupStore {
    static var mockData = [
        Groups(name: "Home Group",
                description: "Household tasks",
               members: ["String"],
               createDate: Date())
    ]

    static var testStore: GroupStore = GroupStore()
}
