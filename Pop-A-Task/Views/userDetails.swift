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
    @State private var showMenu = false
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var cell: String = ""
    @ObservedObject var userData: UserData
    @State private var isEditing = false
    var db = Firestore.firestore()


    var body: some View {
//        ZStack {
//            if showMenu {
//                DrawerView(
//                           categories: $categories,
//                           status: $status,
//                           priority: $priority,
//                           menu: menu,
//                           username: userData.userName ?? "Loading",
//                           isLoggedIn: .constant(true), userData: UserData())
//                    .transition(.slide)
//                    .zIndex(1)
//            }
//
            
            VStack {
                if isEditing {
                    Form {
                        Section {
                            TextField("Name", text: $name)
                                .textContentType(.name)
                                .autocapitalization(.words)
                                .disableAutocorrection(true)
                                .padding(.horizontal)
                                .textCase(.none)
                                .foregroundColor(.primary)
                                .font(.body)
                                .backgroundStyle(.green)
//                                .multilineTextAlignment(.center)
                            
                            TextField("Email", text: $email)
                                .textContentType(.emailAddress)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                .padding(.horizontal)
                                .textCase(.none)
                                .foregroundColor(.primary)
                                .font(.body)
                                .backgroundStyle(.green)
//                                .multilineTextAlignment(.center)

                            
                            TextField("Mobile", text: $cell)
                                .textContentType(.telephoneNumber)
                                .keyboardType(.phonePad)
                                .disableAutocorrection(true)
                                .padding(.horizontal)
                                .textCase(.none)
                                .foregroundColor(.primary)
                                .font(.body)
                                .backgroundStyle(.green)
//                                .multilineTextAlignment(.center)

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
                            if !name.isEmpty && !email.isEmpty && !cell.isEmpty {
                                self.updateUserProfile()
                            }
                        }
                        .frame(height: 50.0)
                    } else {
                        Button("Edit") {
                            // Populate text fields with current data
                            self.name = userData.userName ?? ""
                            self.email = userData.email ?? ""
                            self.cell = userData.cell ?? ""
                            self.isEditing = true
                        }
                        .frame(height: 50.0)
                        
                    }
                }
            }
        }
        

        func updateUserProfile() {
            let data: [String: Any] = ["name": self.name,"email": self.email, "cell": self.cell]
            db.collection("users").document(userData.userID! ).setData(data, merge: true)
        }
    
}

struct userDetails_Previews: PreviewProvider {
    static var previews: some View {
        userDetails(userData: UserData())
       
    }
}
