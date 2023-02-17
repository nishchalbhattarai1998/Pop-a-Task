//
//  GroupStore.swift
//  Pop-A-Task
//
//  Created by Sangam Gurung on 2023-02-14.
//

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
}

extension GroupStore {
    static var testStore: GroupStore = GroupStore()
}
