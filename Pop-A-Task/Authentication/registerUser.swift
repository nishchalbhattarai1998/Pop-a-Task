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
    @State private var cell = ""
    @State private var userID = ""
    
    var body: some View {
        VStack {
            Image("splashLogo")
                .resizable()
                .frame(width: 200, height: 200)
                .padding(.horizontal)
            
            Text("Pop A Task").fontWeight(.heavy)
                .foregroundColor(.green)
                .padding(.bottom, 40)
                .font(.largeTitle)
            
            TextField("Name", text: $name)
                .padding()
                .frame(width: 350.0, height: 50.0)
                .background(Color.gray.opacity(0.1).cornerRadius(15.0))
                .cornerRadius(15.0)
                .padding(10)
            
            TextField("Mobile", text: $cell)
                .padding()
                .frame(width: 350.0, height: 50.0)
                .background(Color.gray.opacity(0.1).cornerRadius(15.0))
                .cornerRadius(15.0)
                .padding(10)
                .keyboardType(.phonePad)
                .onReceive(cell.publisher.collect()) { newValue in
                    let filtered = newValue.filter { $0.isNumber }
                    if filtered.count > 11 {
                        self.cell = String(filtered.prefix(11))
                    } else {
                        self.cell = String(filtered)
                    }
                }

            
            TextField("Email", text: $email)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .padding()
                .frame(width: 350.0, height: 50.0)
                .background(Color.gray.opacity(0.1).cornerRadius(15.0))
                .cornerRadius(15.0)
                .padding(10)
            
            SecureField("Password", text: $password,onCommit: {
                if(email == "" && name == "" || cell == "" && password == ""){
                    errorMessage = "Information missing "
                }
                else{
                    register()
                    
                }
            } )
                .padding()
                .frame(width: 350.0, height: 50.0)
                .background(Color.gray.opacity(0.1).cornerRadius(15.0))
                .cornerRadius(15.0)
                .padding(10)
            
            Button(action: {
                // Handle "New Task" action here
                if(email == "" && name == "" || cell == "" && password == ""){
                    errorMessage = "Information missing "
                }
                else{
                    register()
                    
                }
            }, label: {
                
                Text("Sign Up")
                    .fontWeight(.bold)
                            .padding(0.0)
                            .frame(width: 300.0, height: 50.0, alignment: .center)
                            .background(Color.green)
                            .foregroundColor(Color.white)
                            .cornerRadius(15)
            })
            
                NavigationLink(destination: EmptyView(),isActive: .constant(false)) {
                    Button(action: {
                      presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack{
                            
                            Text("Already have an Account?")
                                .font(.subheadline)
                                .padding([.top, .leading, .bottom])
                            Text("Log In")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(Color("AccentColor"))
                            
                            
                        }.padding(.bottom, 40)
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
            }.padding(.bottom, -10.0)
        }
        
    }
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                // Handle error cases as before
            } else {
                userID.self = Auth.auth().currentUser?.uid ?? ""
                let db = Firestore.firestore()

                // Define your default values for the arrays
                let defaultGroupIDs = ["default_group_1", "default_group_2"]
                let defaultTaskIDs = ["default_task_1", "default_task_2"]

                db.collection("users").document(self.userID).setData([
                    "userID": userID,
                    "email": self.email,
                    "name": self.name,
                    "cell": self.cell,
                    "password": self.password,
                    "groupID": "defaultGroupIDs", // Use the default group IDs
                    "taskID": "defaultTaskIDs"     // Use the default task IDs
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { presentationMode.wrappedValue.dismiss() }
    }

}

struct RegisterView_Previews: PreviewProvider{
    static var previews: some View{
        RegisterView()
    }
}

