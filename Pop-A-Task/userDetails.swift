//
//  userDetails.swift
//  Pop-A-Task
//
//  Created by manpreet Kaur on 2023-02-05.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth

struct userDetails: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var showMenu = false
    let menu = ["Home", "Profile", "Groups", "Tasks", "Help", "Logout"]
    @State private var name: String = ""
    @State private var email: String = ""
    @ObservedObject private var userData = UserData()
    @State private var isEditing = false

    var db = Firestore.firestore()
    let userID = Auth.auth().currentUser?.uid
    init(){ self._name = State(initialValue: userData.userName ?? "Your Name")
        self._email = State(initialValue: userData.email ?? "Your Mail")}
    

    var body: some View {
        ZStack {
            if showMenu {
                DrawerView(menu: menu, username: userData.userName!, isLoggedIn: .constant(false))
                    .transition(.slide)
                    .zIndex(1)
            }
            
            
            VStack {
                if isEditing {
                    Form {
                        Section {
                            TextField("Name", text: $name)
                            TextField("Email", text: $email)
                        }
                    }
                } else {
                    Form {
                        Section {
                            Text("Name: \(name)")
                            Text("Email: \(email)")
                        }
                    }
                }
                HStack {
                    if isEditing {
                        Button("Save") {
                            self.isEditing = false
                            self.updateUserProfile()
                        }
                    } else {
                        Button("Edit") {
                            self.isEditing = true
                        }
                    }
                }
            }
        }
//        .edgesIgnoringSafeArea(.bottom)
            .navigationBarItems(leading:
                Button(action: { self.showMenu.toggle() }) {
                    Image(systemName: "person.circle")
                        .imageScale(.large)
        
    }
                                )
    }

        func updateUserProfile() {
            let data: [String: Any] = ["name": self.name,"email": self.email]
            db.collection("users").document(userID ?? "").setData(data, merge: true)
        }
    

class UserData: ObservableObject {
    @Published var userName: String?
    @Published var email: String?
    init() {
    if Auth.auth().currentUser != nil {

            let userID = Auth.auth().currentUser?.uid ?? ""
            print("\(userID)")
            let db = Firestore.firestore()
            db.collection("users").document(userID).addSnapshotListener { documentSnapshot, error in
                guard let document = documentSnapshot else {
                    print("Error fetching document: \(error!)")
                    return
                }
                self.userName = document.data()?["name"] as? String
                self.email = document.data()?["email"] as? String
            }
    } else {
        print("User not found")
    }

    }
}
    
}

struct userDetails_Previews: PreviewProvider {
    static var previews: some View {
        userDetails()
       
    }
}
