////
////  GroupViewModel.swift
////  Pop-A-Task
////
////  Created by Sangam Gurung on 2023-02-14.
////
//import Foundation
//import Firebase
//import FirebaseFirestoreSwift
//
//class GroupViewModel: ObservableObject {
//        private let db = Firestore.firestore()
//        private var listenerRegistration: ListenerRegistration?
//        @Published var listData = [Groups]()
//        @Published var filteredData = [Groups]()
//        @Published var searchTerm = ""
//        @Published var navTitle = "Groups"
//    @Published var groups = [Groups]()
//
//    func fetchData() {
//        db.collection("groups")
//            .addSnapshotListener { (querySnapshot, error) in
//                guard let documents = querySnapshot?.documents else {
//                    print("No documents")
//                    return
//                }
//                self.groups = documents.compactMap { queryDocumentSnapshot -> Groups? in
//                    try? queryDocumentSnapshot.data(as: Groups.self)
//                }
//        }
//    }
//
//    func addGroup(group: Groups) {
//        do {
//            _ = try db.collection("groups").addDocument(from: group)
//        }
//        catch {
//            print(error)
//        }
//    }
//
//    func deleteGroup(group: Groups) {
//        if let groupID = group.id {
//            db.collection("groups").document(groupID).delete { error in
//                if let error = error {
//                    print("Error removing document: \(error)")
//                }
//            }
//        }
//    }
//
//    func addMember(group: Groups, memberEmail: String) {
//        db.collection("users").whereField("email", isEqualTo: memberEmail)
//            .getDocuments { (querySnapshot, error) in
//                if let error = error {
//                    print("Error getting documents: \(error)")
//                } else {
//                    guard let documents = querySnapshot?.documents else {
//                        print("No documents")
//                        return
//                    }
//                    if let user = documents.first {
//                        let memberID = user.documentID
//                        var updatedMembers = group.members
//                        updatedMembers.append(memberID)
//                        let updatedGroup = Groups(id: group.id, name: group.name, description: group.description, members: updatedMembers, createDate: group.createDate, createBy: group.createBy)
//                        do {
//                            try self.db.collection("groups").document(group.id!).setData(from: updatedGroup)
//                        } catch {
//                            print("Error updating document: \(error)")
//                        }
//                    } else {
//                        print("User not found")
//                    }
//                }
//            }
//    }
//
//    func updateGroup(_ group: Groups) {
//            if let groupID = group.id {
//                do {
//                    try db.collection("groups").document(groupID).setData(from: group)
//                }
//                catch {
//                    fatalError("Unable to encode group: \(error.localizedDescription).")
//                }
//            }
//        }
//
//        func deleteGroup(at offsets: IndexSet) {
//            let groupIDs = offsets.map { listData[$0].id! }
//            for id in groupIDs {
//                db.collection("groups").document(id).delete()
//            }
//        }
//
//        func deleteGroup2(_ documentID: String) {
//            let docRef = db.collection("groups").document(documentID)
//            docRef.delete { error in
//                if let error = error {
//                    print("Error deleting group: \(error.localizedDescription)")
//                } else {
//                    print("Group successfully deleted")
//                }
//            }
//        }
//
//        func moveGroup(from: IndexSet, to: Int) {
//            listData.move(fromOffsets: from, toOffset: to)
//            for i in 0..<listData.count {
//                let id = listData[i].id!
//                db.collection("groups").document(id).updateData(["order": i])
//            }
//        }
//
//        func resetData() {
//            let batch = db.batch()
//            for i in 0..<listData.count {
//                let groupRef = db.collection("groups").document(listData[i].id!)
//                batch.updateData(["order": i], forDocument: groupRef)
//            }
//            batch.commit() { error in
//                if let error = error {
//                    print("Error updating document: \(error)")
//                } else {
//                    print("Batch update succeeded")
//                }
//            }
//        }
//
//        func filterSearchResults() {
//            if searchTerm.isEmpty {
//                filteredData = listData
//            } else {
//                filteredData = listData.filter { group in
//                    group.name.lowercased().contains(searchTerm.lowercased())
//                }
//            }
//        }
//
//        var displayCount: String {
//            if filteredData.count == listData.count {
//                return "\(listData.count) groups"
//            } else {
//                return "\(filteredData.count) of \(listData.count) groups"
//            }
//        }
//}



//  GroupViewModel.swift
//  Pop-A-Task
//
//  Created by Sangam Gurung on 2023-02-14.

//
//import Foundation
//import FirebaseFirestore
//import FirebaseFirestoreSwift
//
//class GroupViewModel: ObservableObject {
//
//    private let db = Firestore.firestore()
//    private var listenerRegistration: ListenerRegistration?
//    var group: Groups
//    @Published var listData = [Groups]()
//    @Published var filteredData = [Groups]()
//    @Published var searchTerm = ""
//    @Published var navTitle = "Groups"
//
//    init() {
//        group = Groups(name: "", description: "", members: [], createDate: Date(), createBy: "")
//        fetchGroups()
//    }
//
//    func fetchGroups() {
//        listenerRegistration = db.collection("groups")
//            .order(by: "name")
//            .addSnapshotListener { (querySnapshot, error) in
//            if let querySnapshot = querySnapshot {
//                self.listData = querySnapshot.documents.compactMap { document in
//                    do {
//                        let group = try document.data(as: Groups.self)
//                        return group
//                    } catch {
//                        print(error)
//                    }
//                    return nil
//                }
//                self.filterSearchResults()
//            }
//        }
//    }
//
//    func addGroup(_ group: Groups) {
//        do {
//            let _ = try db.collection("groups").addDocument(from: group)
//        }
//        catch {
//            fatalError("Unable to encode group: \(error.localizedDescription).")
//        }
//    }
//
//    func updateGroup(_ group: Groups) {
//        if let groupID = group.id {
//            do {
//                try db.collection("groups").document(groupID).setData(from: group)
//            }
//            catch {
//                fatalError("Unable to encode group: \(error.localizedDescription).")
//            }
//        }
//    }
//
//    func deleteGroup(at offsets: IndexSet) {
//        let groupIDs = offsets.map { listData[$0].id! }
//        for id in groupIDs {
//            db.collection("groups").document(id).delete()
//        }
//    }
//
//    func deleteGroup2(_ documentID: String) {
//        let docRef = db.collection("groups").document(documentID)
//        docRef.delete { error in
//            if let error = error {
//                print("Error deleting group: \(error.localizedDescription)")
//            } else {
//                print("Group successfully deleted")
//            }
//        }
//    }
//    //Newly added
////    func addGroupMember(_ member: String) {
////        if var group = listData.first(where: { $0.id == self.group.id }) {
////            group.members.append(member)
////            do {
////                try db.collection("groups").document(group.id!).setData(from: group)
////            } catch {
////                fatalError("Unable to encode group: \(error.localizedDescription).")
////            }
////        }
////    }
////
//    func moveGroup(from: IndexSet, to: Int) {
//        listData.move(fromOffsets: from, toOffset: to)
//        for i in 0..<listData.count {
//            let id = listData[i].id!
//            db.collection("groups").document(id).updateData(["order": i])
//        }
//    }
//
//    func resetData() {
//        let batch = db.batch()
//        for i in 0..<listData.count {
//            let groupRef = db.collection("groups").document(listData[i].id!)
//            batch.updateData(["order": i], forDocument: groupRef)
//        }
//        batch.commit() { error in
//            if let error = error {
//                print("Error updating document: \(error)")
//            } else {
//                print("Batch update succeeded")
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
//        if filteredData.count == listData.count {
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


import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class GroupViewModel: ObservableObject {

    private let db = Firestore.firestore()
    private var listenerRegistration: ListenerRegistration?
    @Published var group = Groups(id:"",name: "", description: "", members: [], createDate: Date(), createBy: "")
    @Published var listData = [Groups]()
    @Published var filteredData = [Groups]()
    @Published var searchTerm = ""
    @Published var navTitle = "Groups"
    var filteredUsers: [(id: String, name: String)] = []

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

    func addMembersToGroup(id: String, members: [String]) {
        print("waycj here")
        print(id + " " + members[0])
        if let groupIndex = listData.firstIndex(where: { $0.id == id }) {
            var updatedGroup = listData[groupIndex]
            updatedGroup.members.append(contentsOf: members)
            updateGroup(updatedGroup)
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

    func filterSearchResultsU(searchTerm: String) {
        if searchTerm.isEmpty {
            self.filteredUsers = []
        } else {
            db.collection("users")
                .whereField("name", isGreaterThanOrEqualTo: searchTerm)
                .whereField("name", isLessThan: searchTerm + "~")
                .getDocuments { querySnapshot, error in
                    if let error = error {
                        print("Error getting search results: \(error.localizedDescription)")
                        //Demo Data for view preview can be removed
                        self.filteredUsers = [(id: "1", name: "John"), (id: "2", name: "Jane"), (id: "3", name: "Bob")]
                        //Demo Data
                    } else {
                        self.filteredUsers = querySnapshot?.documents.map {
                            (id: $0.documentID, name: $0.data()["name"] as? String ?? "")
                        } ?? []
                    }
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
