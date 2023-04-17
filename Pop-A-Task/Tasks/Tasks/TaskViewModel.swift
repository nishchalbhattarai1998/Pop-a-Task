
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
    @Published var filteredData = [Task](){
        didSet {
            updateDeadlineCounts()
        }
    }
    @Published var highPriorityCount = 0
    @Published var mediumPriorityCount = 0
    @Published var lowPriorityCount = 0
    
    @Published var todoCount = 0
    @Published var inProgressCount = 0
    @Published var doneCount = 0
    
    @Published var overdueCount = 0
    @Published var dueSoonCount = 0
    @Published var dueThisWeekCount = 0
    @Published var dueLaterCount = 0
    
    @Published var searchTerm = ""
    @Published var navTitle = "Tasks"
    var filteredUsers: [(id: String, name: String)] = []
    
    @Published var deadlineData: [Double] = [0, 0, 0, 0]
    
    @Published var selectedGroupID: String? {
        didSet {
            filterTasksByGroup()
        }
    }




    
    init() {
        fetchTasks()
        
    }

    
    func fetchTasks() {
        guard let userID = userData.userID else {
            return
        }
        
        // Fetch the groups the user is a member of
        db.collection("groups")
            .whereField("members", arrayContains: userID)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error getting user groups: \(error.localizedDescription)")
                } else {
                    let userGroupIDs = querySnapshot?.documents.map { $0.documentID } ?? []
                    
                    // Check if userGroupIDs array is not empty
                    if !userGroupIDs.isEmpty {
                        // Fetch tasks belonging to the user's groups
                        self.listenerRegistration = self.db.collection("tasks")
                            .whereField("groupID", in: userGroupIDs)
                            .addSnapshotListener { (querySnapshot, error) in
                                if let querySnapshot = querySnapshot {
                                    self.listData = querySnapshot.documents.compactMap { document in
                                        do {
                                            var task = try document.data(as: Task.self)
                                            task.status = task.status?.trimmingCharacters(in: .whitespacesAndNewlines)
                                            return task
                                        } catch {
                                            print(error)
                                        }
                                        return nil
                                    }
                                    self.filterSearchResults()
                                    self.updateDeadlineCounts()
                                    
                                    // Count tasks by priority
                                    self.highPriorityCount = self.filteredData.filter { $0.priority == "High" }.count
                                    self.mediumPriorityCount = self.filteredData.filter { $0.priority == "Medium" }.count
                                    self.lowPriorityCount = self.filteredData.filter { $0.priority == "Low" }.count
                                    
                                    // Count tasks by status
                                    self.todoCount = self.filteredData.filter { $0.status == "ToDo" }.count
                                    self.inProgressCount = self.filteredData.filter { $0.status == "InProgress" }.count
                                    self.doneCount = self.filteredData.filter { $0.status == "Done" }.count
                                }
                            }
                    } else {
                        // If userGroupIDs array is empty, clear the listData and filteredData arrays
                        self.listData = []
                        self.filteredData = []
                    }
                }
            }
        self.filterTasksByGroup()
    }


    
    private func updateDeadlineCounts() {
        let now = Date()
        overdueCount = 0
        dueSoonCount = 0
        dueThisWeekCount = 0
        dueLaterCount = 0

        for task in filteredData {
            guard let deadline = task.deadline, task.status != "Done" else { continue }
            let daysUntilDeadline = Calendar.current.dateComponents([.day], from: now, to: deadline).day ?? 0

            switch daysUntilDeadline {
            case ..<0:
                overdueCount += 1
            case 0...2:
                dueSoonCount += 1
            case 3...7:
                dueThisWeekCount += 1
            default:
                dueLaterCount += 1
            }
        }

        let totalCount = Double(overdueCount + dueSoonCount + dueThisWeekCount + dueLaterCount)

        if totalCount == 0 {
            deadlineData = [0, 0, 0, 0]
        } else {
            deadlineData = [
                Double(overdueCount) / totalCount * 100,
                Double(dueSoonCount) / totalCount * 100,
                Double(dueThisWeekCount) / totalCount * 100,
                Double(dueLaterCount) / totalCount * 100
            ]
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
//        print(id + " " + assigne[0])
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
                        
//                        print(self.filteredUsers)
                    }
                }
        }
    }
    
    func changeTaskGroup(taskID: String, newGroupID: String, newGroupName: String) {
        if let taskIndex = listData.firstIndex(where: { $0.id == taskID }) {
            var updatedTask = listData[taskIndex]
            updatedTask.groupID = newGroupID
            updatedTask.group = newGroupName
            updateTask(updatedTask)
        }
    }

    private func filterTasksByGroup() {
        if let selectedGroupID = selectedGroupID {
            filteredData = listData.filter { task in
                task.groupID == selectedGroupID
            }
        } else {
            filteredData = listData
        }
    }


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


