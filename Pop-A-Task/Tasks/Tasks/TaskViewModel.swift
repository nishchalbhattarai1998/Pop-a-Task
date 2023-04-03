
//
//  demotaskviewmodel.swift
//  Pop-A-Task
//
//  Created by nishchal bhattarai on 2023-04-02.
//

import Foundation

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI

class TaskViewModel: ObservableObject {
    @ObservedObject var userData = UserData()
    let db = Firestore.firestore()
    private var listenerRegistration: ListenerRegistration?
    @Published var task = Task(id: "", name: "", description: "", category: "", status: "", priority: "", assignee: "", group: "", groupID: "", deadline: Date(), createdBy: "", createdAt: Date(), taskID: "")
    @Published var listData = [Task]()
    @Published var filteredData = [Task]()
    @Published var searchTerm = ""
    @Published var navTitle = "Tasks"
    var filteredUsers: [(id: String, name: String)] = []
    
    init() {
        fetchTasks()
        
    }
    func fetchTasks() {
        guard let userID = userData.userID else {
            return
        }
        listenerRegistration = db.collection("tasks")
            .order(by: "name")
//            .whereField("members", arrayContains: userID)
            .addSnapshotListener { (querySnapshot, error) in
                if let querySnapshot = querySnapshot {
                    self.listData = querySnapshot.documents.compactMap { document in
                        do {
                            let task = try document.data(as: Task.self)
                            return task
                        } catch {
                            print(error)
                        }
                        return nil
                    }
                    self.filterSearchResults()
                }
            }
    }
    
    
    
    func addTask(_ group: Groups) {
        do {
            let _ = try db.collection("tasks").addDocument(from: group)
        }
        catch {
            fatalError("Unable to encode task: \(error.localizedDescription).")
        }
    }
    
    func updateTask(_ task: Task) {
        if let taskID = task.id {
            do {
                try db.collection("tasks").document(taskID).setData(from: task)
            }
            catch {
                fatalError("Unable to encode task: \(error.localizedDescription).")
            }
        }
    }
    
    
    func deletaTask(_ documentID: String) {
        let docRef = db.collection("tasks").document(documentID)
        docRef.delete { error in
            if let error = error {
                print("Error deleting task: \(error.localizedDescription)")
            } else {
                print("Task successfully deleted")
            }
        }
    }
    
    func addMembersToTask(id: String, assigne: [String]) {
        print(id + " " + assigne[0])
        if let taskindex = listData.firstIndex(where: { $0.id == id }) {
            var updatedTask = listData[taskindex]
            for member in assigne {
                if updatedTask.assignee!.contains(member) {
                    print("User \(member) is already a member of this task")
                } else {
                    updatedTask.assignee?.append(member)
                }
            }
            updateTask(updatedTask)
        }
    }
    
    func moveTask(from: IndexSet, to: Int) {
        listData.move(fromOffsets: from, toOffset: to)
        
        // Update the order field of the Firestore documents
        for i in 0..<listData.count {
            let groupID = listData[i].groupID!
            db.collection("tasks").document(groupID).updateData(["order": i])
        }
        
        // Update the filteredData array, if applicable
        filterSearchResults()
    }
    
    
    func resetData() {
        let batch = db.batch()
        for i in 0..<listData.count {
            let groupRef = db.collection("tasks").document(listData[i].id!)
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
                        
                        print(self.filteredUsers)
                    }
                }
        }
    }
//    func getTaskID(taskName: String) -> String? {
//        filteredData.first(where: { $0.name == taskName })?.id
//    }
    
    var displayCount: String {
        if filteredData.count == listData.count {
            return "\(listData.count) tasks"
        } else {
            return "\(filteredData.count) of \(listData.count) tasks"
        }
    }
    
    deinit {
        listenerRegistration?.remove()
    }
}


