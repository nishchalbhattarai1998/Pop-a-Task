import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI

class CategoryViewModel: ObservableObject {
    @ObservedObject var userData = UserData()
    private let db = Firestore.firestore()
    private var listenerRegistration: ListenerRegistration?
    @Published var categories = Category(id:"",name: "", tasks: [""], createDate: Date(), createBy: "", categoryID: "")
    @Published var cListData = [Category]()
    
    init() {
        fetchCategories()
    }
    
    func fetchCategories() {
        guard let userID = userData.userID else {
            return
        }
        listenerRegistration = db.collection("categories")

            .order(by: "name")
            .addSnapshotListener { (querySnapshot, error) in
                if let querySnapshot = querySnapshot {
                    self.cListData = querySnapshot.documents.compactMap { document in
                        do {
                            let cat = try document.data(as: Category.self)
                            return cat
                        } catch {
                            print(error)
                        }
                        return nil
                    }
                }
            }
    }
    
    func addCategory(_ categories: Category) {
        guard let userID = userData.userID else {
            print("Error: User ID is not available.")
            return
        }

        var newCategory = categories
        newCategory.createDate = Date()
        newCategory.createBy = userID

        do {
            let documentRef = try db.collection("categories").addDocument(from: newCategory)
            let categoryID = documentRef.documentID
            db.collection("categories").document(categoryID).updateData(["categoryID": categoryID]) { error in
                if let error = error {
                    print("Error updating categoryID: \(error.localizedDescription)")
                }
            }
        }
        catch {
            fatalError("Unable to encode category: \(error.localizedDescription).")
        }
    }

    
    deinit {
        listenerRegistration?.remove()
    }
}

class PriorityViewModel: ObservableObject {
    @ObservedObject var userData = UserData()
    private let db = Firestore.firestore()
    private var listenerRegistration: ListenerRegistration?
    @Published var priorities = Priority(id:"",name: "", tasks: [""], createDate: Date(), createBy: "", priorityID: "")
    @Published var pListData = [Priority]()
    
    init() {
        fetchPriorities()
    }
    
    func fetchPriorities() {
        guard let userID = userData.userID else {
            return
        }
        listenerRegistration = db.collection("priorities")

            .order(by: "name")
            .addSnapshotListener { (querySnapshot, error) in
                if let querySnapshot = querySnapshot {
                    self.pListData = querySnapshot.documents.compactMap { document in
                        do {
                            let prio = try document.data(as: Priority.self)
                            return prio
                        } catch {
                            print(error)
                        }
                        return nil
                    }
                }
            }
    }
    
    func addPriority(_ priorities: Priority) {
        guard let userID = userData.userID else {
            print("Error: User ID is not available.")
            return
        }

        var newPriority = priorities
        newPriority.createDate = Date()
        newPriority.createBy = userID

        do {
            let documentRef = try db.collection("priorities").addDocument(from: newPriority)
            let priorityID = documentRef.documentID
            db.collection("priorities").document(priorityID).updateData(["priorityID": priorityID]) { error in
                if let error = error {
                    print("Error updating priorityID: \(error.localizedDescription)")
                }
            }
        }
        catch {
            fatalError("Unable to encode priority: \(error.localizedDescription).")
        }
    }

    
    deinit {
        listenerRegistration?.remove()
    }
}

class StatusViewModel: ObservableObject {
    @ObservedObject var userData = UserData()
    private let db = Firestore.firestore()
    private var listenerRegistration: ListenerRegistration?
    @Published var status = Status(id:"",name: "", tasks: [""], createDate: Date(), createBy: "", statusID: "")
    @Published var sListData = [Status]()
    
    init() {
        fetchStatus()
    }
    
    func fetchStatus() {
        guard let userID = userData.userID else {
            return
        }
        listenerRegistration = db.collection("status")

            .order(by: "name")
            .addSnapshotListener { (querySnapshot, error) in
                if let querySnapshot = querySnapshot {
                    self.sListData = querySnapshot.documents.compactMap { document in
                        do {
                            let stat = try document.data(as: Status.self)
                            return stat
                        } catch {
                            print(error)
                        }
                        return nil
                    }
                }
            }
    }
    
    func addStatus(_ status: Status) {
        guard let userID = userData.userID else {
            print("Error: User ID is not available.")
            return
        }

        var newStatus = status
        newStatus.createDate = Date()
        newStatus.createBy = userID

        do {
            let documentRef = try db.collection("status").addDocument(from: newStatus)
            let statusID = documentRef.documentID
            db.collection("status").document(statusID).updateData(["statusID": statusID]) { error in
                if let error = error {
                    print("Error updating statusID: \(error.localizedDescription)")
                }
            }
        }
        catch {
            fatalError("Unable to encode status: \(error.localizedDescription).")
        }
    }

    
    deinit {
        listenerRegistration?.remove()
    }
}

