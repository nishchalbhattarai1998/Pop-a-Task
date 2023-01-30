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
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
            }
            .padding()
            .frame(width: 350.0, height: 50.0)
            .background(Color.green)
            .foregroundColor(Color.white)
            .cornerRadius(5.0)
            .padding()

        }

        }
    }


