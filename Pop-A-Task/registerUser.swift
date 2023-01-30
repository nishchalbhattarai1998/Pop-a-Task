//
//  registerUser.swift
//  Pop-A-Task
//
//  Created by Charles Roy on 2023-01-30.
//

import Foundation
import SwiftUI
import Firebase

struct RegisterView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var name = ""
    
    var body: some View {
        VStack {
            TextField("Name", text: $name)
                .padding()
                .background(Color.gray)
                .cornerRadius(5.0)
            
            TextField("Email", text: $email)
                .padding()
                .background(Color.gray)
                .cornerRadius(5.0)
            
            SecureField("Password", text: $password)
                .padding()
                .background(Color.gray)
                .cornerRadius(5.0)
            
            Button(action: register) {
                Text("Register")
            }
        }
    }
}

