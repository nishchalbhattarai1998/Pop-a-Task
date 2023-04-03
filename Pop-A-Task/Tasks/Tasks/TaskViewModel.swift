//
//  TaskViewModel.swift
//  Pop-A-Task
//
//  Created by manpreet Kaur on 2023-03-20.
//

import Foundation

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class TaskViewModel: ObservableObject {
    
    let db = Firestore.firestore()
    
    @Published var tasks = [Task]()
    @Published var filteredTasks = [Task]()
    @Published var searchTaskTerm = ""
    
    var taskCount: Int {
        tasks.count
    }
    
    func createTask(_ task: Task) {
        do {
            let taskRef = try db.collection("tasks").addDocument(from: task)
            let taskID = taskRef.documentID
            var updatedTask = task
            updatedTask.id = taskID
            try taskRef.setData(from: updatedTask)
            print("Task added successfully to Firestore")
        } catch let error {
            print("Error adding task to Firestore: \(error.localizedDescription)")
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
                do {
                    if let task = try document.data(as: Task.self, with: .estimate) as Task? {
                        tasks.append(task)
                    }
                } catch let error {
                    print("Error decoding task: \(error.localizedDescription)")
                }
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
