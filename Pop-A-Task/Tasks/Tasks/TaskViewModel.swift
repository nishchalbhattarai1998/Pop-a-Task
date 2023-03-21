//
//  TaskViewModel.swift
//  Pop-A-Task
//
//  Created by manpreet Kaur on 2023-03-20.
//

import Foundation
import Firebase
import FirebaseFirestore

class TaskViewModel: ObservableObject {
    
    let db = Firestore.firestore()
    
    @Published var tasks = [Task]()
    @Published var filteredTasks = [Task]()
    @Published var searchTaskTerm = ""
    
    var taskCount: Int {
        tasks.count
    }
    
    func createTask(_ task: Task) {
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        ref = db.collection("tasks").addDocument(data: [
            "name": task.name,
            "description": task.description ?? "",
            "category": task.category ?? "",
            "status": task.status ?? "",
            "priority": task.priority ?? "",
            "assignee": task.assignee ?? "",
            "group": task.group ?? "",
            "deadline": task.deadline ?? Date(),
            "createdBy": task.createdBy ?? "",
            "createdAt": task.createdAt ?? Date()
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    func fetchTasks(completion: @escaping ([Task]) -> Void) {
        db.collection("tasks").addSnapshotListener { snapshot, error in
            guard let documents = snapshot?.documents else {
                print("Error fetching documents: \(error!)")
                return
            }
            
            var tasks = [Task]()
            
            for document in documents {
                let data = document.data()
                
                let id = document.documentID
                let name = data["name"] as? String ?? ""
                let description = data["description"] as? String ?? ""
                let category = data["category"] as? String ?? ""
                let status = data["status"] as? String ?? ""
                let priority = data["priority"] as? String ?? ""
                let assignee = data["assignee"] as? String ?? ""
                let group = data["group"] as? String ?? ""
                let deadlineTimestamp = data["deadline"] as? Timestamp ?? Timestamp()
                let deadline = deadlineTimestamp.dateValue()
                let createdBy = data["createdBy"] as? String ?? ""
                let createdAtTimestamp = data["createdAt"] as? Timestamp ?? Timestamp()
                let createdAt = createdAtTimestamp.dateValue()
                
                let task = Task(id: id, name: name, description: description, category: category, status: status, priority: priority, assignee: assignee, group: group, deadline: deadline, createdBy: createdBy, createdAt: createdAt)
                
                tasks.append(task)
            }
            
            completion(tasks)
        }
    }



    
    func deleteTask(_ task: Task) {
        if let taskID = task.id {
            db.collection("tasks").document(taskID).delete { error in
                if let error = error {
                    print("Error deleting task: \(error.localizedDescription)")
                } else {
                    print("Task successfully deleted")
                }
            }
        }
    }
    
    func moveTask(from: IndexSet, to: Int) {
        tasks.move(fromOffsets: from, toOffset: to)
        
       
        for i in 0..<tasks.count {
            let taskID = tasks[i].id
            db.collection("tasks").document(taskID!).updateData(["order": i])
        }
        
        
        filterTasks()
    }
    
    func filterTasks() {
        if searchTaskTerm.isEmpty {
            filteredTasks = tasks
        } else {
            filteredTasks = tasks.filter { task in
                task.name.lowercased().contains(searchTaskTerm.lowercased())
            }
        }
    }
    
    func resetData() {
        let batch = db.batch()
        for i in 0..<tasks.count {
            let taskRef = db.collection("tasks").document(tasks[i].id!)
            batch.updateData(["order": i], forDocument: taskRef)
        }
        batch.commit() { error in
            if let error = error {
                print("Error updating document: \(error)")
            } else {
                print("Batch update succeeded")
            }
        }
    }
    
    func filterSearchResults(searchTerm: String, completion: @escaping (_ users: [(id: String, name: String)]) -> Void) {
        if searchTerm.isEmpty {
            completion([])
        } else {
            db.collection("users")
                .whereField("name", isGreaterThanOrEqualTo: searchTerm)
                .whereField("name", isLessThan: searchTerm + "~")
                .getDocuments { querySnapshot, error in
                    if let error = error {
                        print("Error getting search results: \(error.localizedDescription)")
                        completion([])
                    } else {
                        let filteredUsers = querySnapshot?.documents.map {
                            (id: $0.documentID, name: $0.data()["name"] as? String ?? "")
                        } ?? []
                        completion(filteredUsers)
                    }
                }
        }
    }
}
