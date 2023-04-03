//
//  Users.swift
//  Pop-A-Task
//
//  Created by Charles Roy on 2023-04-01.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct User: Codable, Identifiable {
    @DocumentID var id: String?
    var userID: String
    var email: String
    var name: String
    var cell: String
    var password: String
    var groupID: [String: Any]
    var taskID: [String: Any]

    enum CodingKeys: String, CodingKey {
        case userID
        case email
        case name
        case cell
        case password
        case groupID
        case taskID
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        userID = try container.decode(String.self, forKey: .userID)
        email = try container.decode(String.self, forKey: .email)
        name = try container.decode(String.self, forKey: .name)
        cell = try container.decode(String.self, forKey: .cell)
        password = try container.decode(String.self, forKey: .password)
        let groupIDArray = try container.decode([String].self, forKey: .groupID)
        groupID = Dictionary(uniqueKeysWithValues: groupIDArray.map { ($0, true) })
        let taskIDArray = try container.decode([String].self, forKey: .taskID)
        taskID = Dictionary(uniqueKeysWithValues: taskIDArray.map { ($0, true) })
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(userID, forKey: .userID)
        try container.encode(email, forKey: .email)
        try container.encode(name, forKey: .name)
        try container.encode(cell, forKey: .cell)
        try container.encode(password, forKey: .password)
        let groupIDArray = Array(groupID.keys)
        try container.encode(groupIDArray, forKey: .groupID)
        let taskIDArray = Array(taskID.keys)
        try container.encode(taskIDArray, forKey: .taskID)
    }
}

class UserViewModel: ObservableObject {
    @Published var users = [User]()
    private var db = Firestore.firestore()

    init() {
        // Fetch all users immediately
        fetchAllUsers()
    }

    func fetchAllUsers() {
        db.collection("users")
            .getDocuments { querySnapshot, error in
                if let error = error {
                    print("Error getting all users: \(error.localizedDescription)")
                } else {
                    let fetchedUsers = querySnapshot?.documents.compactMap { queryDocumentSnapshot -> User? in
                        let data = queryDocumentSnapshot.data()
                        var user = try? queryDocumentSnapshot.data(as: User.self)
                        user?.id = queryDocumentSnapshot.documentID
                        return user
                    } ?? []
                    self.users = fetchedUsers
                    print("All users fetched: \(self.users)")
                }
            }
    }


    func addUser(user: User) {
        do {
            let _ = try db.collection("users").addDocument(from: user)
        } catch {
            print("Error adding user: \(error.localizedDescription)")
        }
    }

    func updateUser(user: User) {
        if let userID = user.id {
            do {
                try db.collection("users").document(userID).setData(from: user)
            } catch {
                print("Error updating user: \(error.localizedDescription)")
            }
        }
    }

    func deleteUser(user: User) {
        if let userID = user.id {
            db.collection("users").document(userID).delete { error in
                if let error = error {
                    print("Error deleting user: \(error.localizedDescription)")
                }
            }
        }
    }
}
