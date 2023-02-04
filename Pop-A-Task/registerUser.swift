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
    @State private var email = ""
    @State private var password = ""
    @State private var name = ""
    
    var body: some View {
        VStack {
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
            }
            .padding()
            .frame(width: 350.0, height: 50.0)
            .background(Color.green)
            .foregroundColor(Color.white)
            .cornerRadius(5.0)
            .padding()
            
        }
        
    }
    func register() {
        //        Auth.auth().createUser(withEmail: email, password: password){
        //            result, error in
        //            if error != nil{
        //                print(error!.localizedDescription)
        //            }
        //        }
        //        // Save data to Firestore
        //        let db = Firestore.firestore()
        //        db.collection("users").document(email).setData([
        //            "email": email,
        //            "password": password,
        //            "name": name
        //        ]) { err in
        //            if let err = err {
        //                print("Error writing document: \(err)")
        //            } else {
        //                print("Document successfully written!")
        //            }
        //        }
        //    }
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("Error creating user: \(error)")
            } else {
                let db = Firestore.firestore()
                db.collection("users").document(self.email).setData([
                    "email": self.email,
                    "password": self.password,
                    "name": self.name
                ]) { (error) in
                    if let error = error {
                        print("Error writing document: \(error)")
                    } else {
                        print("Document successfully written!")
                    }
                }
            }
        }
    }
}

