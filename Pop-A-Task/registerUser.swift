//
//  registerUser.swift
//  Pop-A-Task
//
//  Created by Charles Roy on 2023-01-30.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth

struct RegisterView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var errorMessage: String = ""
    @State private var email = ""
    @State private var password = ""
    @State private var name = ""
    @State private var userID = ""
    
    var body: some View {
        VStack {
            Image(systemName: "lines.measurement.horizontal")
                .padding(.top, 0.0)
                .imageScale(.large)
                .foregroundColor(.green)
            
            Text("Pop A Task").fontWeight(.bold)
                .foregroundColor(.green)
                .padding(.bottom, 100.0)
            
            TextField("Name", text: $name)
                .padding()
                .frame(width: 350.0, height: 50.0)
                .background(Color(hue: 0.345, saturation: 0.095, brightness: 0.952))
                .cornerRadius(5.0)
                .padding(10)
            
            TextField("Email", text: $email)
                .padding()
                .frame(width: 350.0, height: 50.0)
                .background(Color(hue: 0.345, saturation: 0.095, brightness: 0.952))
                .cornerRadius(5.0)
                .padding(10)
            
            SecureField("Password", text: $password)
                .padding()
                .frame(width: 350.0, height: 50.0)
                .background(Color(hue: 0.345, saturation: 0.095, brightness: 0.952))
                .cornerRadius(5.0)
                .padding(10)
            Button("Sign Up") {
                register()
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
            .frame(width: 350.0, height: 50.0)
            .background(Color.green)
            .foregroundColor(Color.white)
            .cornerRadius(5.0)
            .padding()
            
                NavigationLink(destination: EmptyView(),isActive: .constant(false)) {
                    Button(action: {
                      presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack{
                            
                            Text("Already have an Account?")
                                .font(.subheadline)
                                .foregroundColor(Color.black)
                                .padding([.top, .leading, .bottom])
                            Text("Log In")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(Color("AccentColor"))
                            
                            
                        }.padding(.bottom, 100.0)
                    }
                }
            VStack{
                if errorMessage == "Successfully Registered" {
                    Text("\(errorMessage)")
                    .font(.body)
                    .foregroundColor(.green)
                }
                else{
                    Text("\(errorMessage)")
                    .font(.body)
                    .foregroundColor(.red)
                    .padding()
                }
            }.padding(.bottom, -50.0)
        }
        
    }
     func register() {
         
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                switch error.localizedDescription {
                case "The email address is badly formatted.":
                    self.errorMessage = "Invalid email format."
                case "The email address is already in use by another account.":
                    self.errorMessage = "Email already in use."
                case "Password should be at least 6 characters":
                    self.errorMessage = "Password must be at least 6 characters."
                default:
                    self.errorMessage = "Sign up failed. Try again."
                }
            }  else {
                userID.self = Auth.auth().currentUser?.uid ?? ""
                let db = Firestore.firestore()
                db.collection("users").document(self.userID).setData([
                    "userID": userID,
                    "email": self.email,
                    "password": self.password,
                    "name": self.name
                ]) { (error) in
                    if let error = error {
                        print("Error writing document: \(error)")
                    } else {
                        print("Document successfully written!")
                        errorMessage = "Successfully Registered"
                    }
                }
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider{
    static var previews: some View{
        RegisterView()
    }
}

