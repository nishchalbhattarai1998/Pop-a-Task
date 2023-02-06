//
//  ContentView.swift
//  Pop-A-Task
//
//  Created by nishchal bhattarai on 2023-01-16.
//
import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth


struct ContentView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var isLoggedIn: Bool = false

        var body: some View {
            Group {
                if isLoggedIn {
                    HomeView(isLoggedIn: $isLoggedIn)
                        .onAppear {
                            print("isLoggedIn if state: \(self.isLoggedIn)")
                        }
                    
                } else {
                    LoginView(isLoggedIn: $isLoggedIn)
                        .onAppear {
                            print("isLoggedIn else state: \(self.isLoggedIn)")
                        }
                }
            }
        }
}
    
    struct LoginView: View {
    @Binding var isLoggedIn: Bool
    @State var email = "";
    @State var password = "";
//    @State private var error = false
    @State private var errorMessage: String = ""
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
                    .padding(5)
                
                SecureField("Password", text: $password)
                    .padding()
                    .frame(width: 300.0, height: 50.0)
                    .background(Color(hue: 0.345, saturation: 0.095, brightness: 0.952))
                    .cornerRadius(5.0)
                    .padding(5)
                    .padding(.bottom, 10.0)
                Button("Login") {
                    if isLoggedIn{
                        self.isLoggedIn = false
                        login()
                    }else{
                        login()
                    }
                    
//                    self.isLoggedIn = false
                }
                .fontWeight(.bold)
                .padding(0.0)
                .frame(width: 300.0, height: 50.0)
                .background(Color.green)
                .foregroundColor(Color.white)
                .cornerRadius(5.0)
                
                NavigationLink(destination: RegisterView().navigationBarBackButtonHidden(true)) {
                    HStack{
                        
                        Text("Don't have an Account?")
                            .font(.subheadline)
                            .foregroundColor(Color.black)
                            .padding([.top, .leading, .bottom])
                        Text("Sign Up")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(Color("AccentColor"))
                    }
                    .padding(.bottom, 100.0)

                }
                VStack{
                                    Text("\(errorMessage)")
                                        .font(.body)
                                        .foregroundColor(.red)
                                        .padding()
                }.padding(.bottom, -50.0)
                
            }
        }
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password){
            result, error in
//            if error != nil{
//                self.error = true
//                print(error!.localizedDescription)
//                        print("isLoggedIn if state login tap: \(self.isLoggedIn)")
//                return
//            }
            if let error = error {
                switch error.localizedDescription {
                case "The email address is badly formatted.":
                    self.errorMessage = "Invalid email format."
                case "The password is invalid or the user does not have a password.":
                    self.errorMessage = "Invalid password."
                case "There is no user record corresponding to this identifier. The user may have been deleted.":
                    self.errorMessage = "User not found."
                default:
                    self.errorMessage = "Login failed. Try again."
                }
            }
            else{
                print("Login successful")
                self.isLoggedIn = true
                print("isLoggedIn if state login tap ok: \(self.isLoggedIn)")
            }
            
        }
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


