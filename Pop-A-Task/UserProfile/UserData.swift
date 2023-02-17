//
//  UserData.swift
//  Pop-A-Task
//
//  Created by Sangam Gurung on 2023-02-06.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class UserData: ObservableObject {
    @Published var userName: String?
    @Published var email: String?
    @Published var userID: String?
    @Published var cell: String?

    init() {
        if Auth.auth().currentUser != nil {
            userID = Auth.auth().currentUser?.uid
            let db = Firestore.firestore()
            db.collection("users").document(userID!).addSnapshotListener { documentSnapshot, error in
                guard let document = documentSnapshot else {
                    print("Error fetching document: \(error!)")
                    return
                }
                self.userName = document.data()?["name"] as? String
                self.email = document.data()?["email"] as? String
                self.cell = document.data()?["cell"] as? String
                print(self.userID!)
                print(self.userName ?? "")
                print(self.email ?? "")
                print(self.cell ?? "")
            }
        } else {
            print("User not found in UserData")
        }
    }
}
