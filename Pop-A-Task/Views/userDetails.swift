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
    @Binding var categories: [String]
    @Binding var status: [String]
    @Binding var priority: [String]

    var body: some View {
        VStack {
            if isLoggedIn {
                HelpV(categories: $categories, status: $status, priority: $priority)
                    .onAppear {
                        print("isLoggedIn if state home: \(self.isLoggedIn)")
                        
                    }
            } else {
                LoginView(isLoggedIn: $isLoggedIn)
                    .onAppear {
                        print("isLoggedIn else state home: \(self.isLoggedIn)")
                    }
            }
        }
    }
}
                    
                

struct user: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var categories: [String]
    @Binding var status: [String]
    @Binding var priority: [String]
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
                DrawerView(
                           categories: $categories,
                           status: $status,
                           priority: $priority,
                           menu: menu,
                           username: userData.userName ?? "Loading",
                           isLoggedIn: .constant(true), userData: UserData())
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
        userDetails(isLoggedIn: .constant(true), categories: .constant(["Household", "Sports", "Grocery", "Utility"]), status: .constant(["To Do", "In Progress", "Done", "Cancelled"]), priority: .constant(["High", "Medium", "Low"]))
       
    }
}
