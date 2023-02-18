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
    @Binding var isLoggedIn: Bool

        var body: some View {
            Group {
                if isLoggedIn {
                    user(userData: UserData())
                } else {
                    LoginView(isLoggedIn: $isLoggedIn)
                }
            }
        }
}

struct user: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var showMenu = false
    let menu = ["Home", "Profile", "Groups", "Tasks", "Help", "Logout"]
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var cell: String = ""
    @ObservedObject var userData: UserData
    @State private var isEditing = false
//    @Binding var isLoggedIn: Bool

    var db = Firestore.firestore()
//    let userID = Auth.auth().currentUser!.uid
//    init(){ self._name = State(initialValue: userData.userName ?? "Your Name")
//        self._email = State(initialValue: $userData.email ?? "Your Mail")}
    

    var body: some View {
        ZStack {
            if showMenu {
                DrawerView(menu: menu, username: userData.userName ?? "no name ud", isLoggedIn: .constant(true), userData: UserData())
                    .transition(.slide)
                    .zIndex(1)
            }
            
            
            VStack {
                if isEditing {
                    Form {
                        Section {
                            TextField("Name", text: $name)
                            TextField("Email", text: $email)
                            TextField("Mobile", text: $cell)
                        }
                    }
                } else {
                    Form {
                        Section {
                            Text("Name: \(userData.userName ?? "")")
                            Text("Email: \(userData.email ?? "")")
                            Text("Mobile: \(userData.cell ?? "")")
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
            let data: [String: Any] = ["name": self.name,"email": self.email, "cell": self.cell]
            db.collection("users").document(userData.userID! ).setData(data, merge: true)
        }
    
}

struct userDetails_Previews: PreviewProvider {
    static var previews: some View {
        userDetails(isLoggedIn: .constant(true))
       
    }
}