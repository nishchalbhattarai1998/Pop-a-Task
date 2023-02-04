//
//  ContentView.swift
//  Pop-A-Task
//
//  Created by nishchal bhattarai on 2023-01-16.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth


struct ContentView: View {
    @State var email = "";
    @State var password = "";
    var body: some View {
        NavigationView {
            
            VStack {
                //comment1
                Image(systemName: "lines.measurement.horizontal")
                    .padding(.top, 0.0)
                    .imageScale(.large)
                    .foregroundColor(.green)
                Text("Pop A Task").fontWeight(.bold)
                    .foregroundColor(.green)
                    .padding(.bottom, 100.0)
                
                TextField("Email", text: $email)
                    .padding()
                    .frame(width: 300.0, height: 50.0)
                    .background(Color(hue: 0.345, saturation: 0.095, brightness: 0.952))
                    .cornerRadius(5.0)
                    .padding(10)
                
                SecureField("Password", text: $password)
                    .padding()
                    .frame(width: 300.0, height: 50.0)
                    .background(Color(hue: 0.345, saturation: 0.095, brightness: 0.952))
                    .cornerRadius(5.0)
                    .padding(10)
                    .padding(.bottom, 250.0)
                
                Button("Login") {
                    login()
                }
                .fontWeight(.bold)
                .padding(0.0)
                .frame(width: 300.0, height: 50.0)
                .background(Color.green)
                .foregroundColor(Color.white)
                .cornerRadius(5.0)
                
                NavigationLink(destination: RegisterView()) {
                    Button("Sign Up") {
                        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                    }
                    .fontWeight(.bold)
                    .padding(0.0)
                    .frame(width: 300.0, height: 50.0)
                    .background(Color(hue: 0.343, saturation: 0.361, brightness: 0.978))
                    .foregroundColor(Color.green)
                    .cornerRadius(5.0)
                }
                
                
            }
        }
    }
    func login() {
        Auth.auth().signIn(withEmail: email, password: password){
            result, error in
            if error != nil{
                print(error!.localizedDescription)
            }
        }
    print("signin clicked")
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


