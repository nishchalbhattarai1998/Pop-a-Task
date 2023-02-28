
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI

class GroupViewModel: ObservableObject {
    @ObservedObject var userData = UserData()
    private let db = Firestore.firestore()
    private var listenerRegistration: ListenerRegistration?
    @Published var group = Groups(id:"",name: "", description: "", members: [], createDate: Date(), createBy: "", groupID: "")
    @Published var listData = [Groups]()
    @Published var filteredData = [Groups]()
    @Published var searchTerm = ""
    @Published var navTitle = "Groups"
    var filteredUsers: [(id: String, name: String)] = []

    init() {
        fetchGroups()
        
    }

//    func fetchGroups() {
//        listenerRegistration = db.collection("groups")
//            .order(by: "name")
//            .addSnapshotListener { (querySnapshot, error) in
//                if let querySnapshot = querySnapshot {
//                    self.listData = querySnapshot.documents.compactMap { document in
//                        do {
//                            let group = try document.data(as: Groups.self)
//                            return group
//                        } catch {
//                            print(error)
//                        }
//                        return nil
//                    }
//                    self.filterSearchResults()
//                }
//            }
//
//    }

    func fetchGroups() {
        guard let userID = userData.userID else {
            return
        }
        listenerRegistration = db.collection("groups")
            .order(by: "name")
            .whereField("members", arrayContains: userID)
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

//    func deleteGroup2(at offsets: IndexSet) {
//        let groupIDs = offsets.map { listData[$0].id! }
//        for id in groupIDs {
//            db.collection("groups").document(id).delete()
//        }
//    }

    func deleteGroup(_ documentID: String) {
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
            for member in members {
                if updatedGroup.members.contains(member) {
                    print("User \(member) is already a member of this group")
                } else {
                    updatedGroup.members.append(member)
                }
            }
            updateGroup(updatedGroup)
        }
    }
    
    func moveGroup(from: IndexSet, to: Int) {
        listData.move(fromOffsets: from, toOffset: to)

        // Update the order field of the Firestore documents
        for i in 0..<listData.count {
            let groupID = listData[i].groupID
            db.collection("groups").document(groupID).updateData(["order": i])
        }

        // Update the filteredData array, if applicable
        filterSearchResults()
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
