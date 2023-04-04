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
    @State var isLoggedIn:Bool =  false
    @State private var selectedTab = 0

    var body: some View {
        VStack {
            if isLoggedIn {
                SplashView(isLoggedIn: $isLoggedIn)
            } else {
                LoginView(isLoggedIn: $isLoggedIn)
            }
        }
    }
}
    
    struct LoginView: View {
    @Binding var isLoggedIn: Bool
    @State var email = "charles@mail.com";
    @State var password = "Charles123";
//    @State private var error = false
    @State private var errorMessage: String = ""
    var body: some View {
        NavigationView {
            
            VStack {
                //comment1
                Image(systemName: "lines.measurement.horizontal")
                    .padding(.top, 40.0)
                    .imageScale(.large)
                    .foregroundColor(.green)
                    .font(.largeTitle)
                    
                
                Text("Pop A Task").fontWeight(.heavy)
                    .foregroundColor(.green)
                    .padding(.bottom, 40)
                    .font(.largeTitle)
                
                TextField("Email", text: $email)
                    .autocapitalization(.none).padding()
                    .frame(width: 300.0, height: 50.0)
                    .background(Color.gray.opacity(0.1).cornerRadius(15.0))
                    .cornerRadius(15.0)
                    .padding(.top, 90)
                    .padding(5)
                
                
                SecureField("Password", text: $password,onCommit: {
                    if isLoggedIn && email != ""{
                        self.isLoggedIn = false
                        login()
                    }else{
                        login()
                    }
                })
                //
                
                .padding()
                .frame(width: 300.0, height: 50.0)
                .background(Color.gray.opacity(0.1).cornerRadius(15.0))
                .cornerRadius(15.0)
                .padding(5)
                .padding(.bottom, 10.0)
                
                Button(action: {
                    // Handle "New Task" action here
                    if isLoggedIn{
                        self.isLoggedIn = false
                        login()
                    }else{
                        login()
                    }
                }, label: {
                    
                    Text("Login")
                        .fontWeight(.bold)
                                .padding(0.0)
                                .frame(width: 300.0, height: 50.0, alignment: .center)
                                .background(Color.green)
                                .foregroundColor(Color.white)
                                .cornerRadius(15)
                })
                
                NavigationLink(destination: RegisterView().navigationBarBackButtonHidden(true)) {
                    HStack{
                        
                        Text("Don't have an Account?")
                            .font(.subheadline)
                            .padding([.top, .leading, .bottom])
                        Text("Sign Up")
                            .font(.headline)
//                            .fontWeight(.bold)
                            .foregroundColor(Color("AccentColor"))
                    }
                    .padding(.top)
                    .padding(.bottom, 0)

                }
                NavigationLink(destination: ResetPasswordView().navigationBarBackButtonHidden(false)) {
                    HStack{
                        
                        Text("Forgot pass?")
                            .font(.subheadline)
//                            .padding([.top, .leading, .bottom])
                        Text("Reset")
                            .font(.headline)
//                            .fontWeight(.bold)
                            .foregroundColor(Color("AccentColor"))
                    }
//                    .padding(.top, 50)
                    .padding(.bottom, 0)

                }
                VStack{
                    Text("\(errorMessage)")
                    .font(.body)
                    .foregroundColor(.red)
                    .padding()
                }.padding(.bottom, 50.0)
                
            }
        }
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password){
            result, error in
            if let error = error {
                switch error.localizedDescription {
                case "The email address is badly formatted.":
                    self.errorMessage = "Invalid email format or password."
                case "The password is invalid or the user does not have a password.":
                    self.errorMessage = "Invalid email format or password."
                case "There is no user record corresponding to this identifier. The user may have been deleted.":
                    self.errorMessage = "User not found. Register to get access. "
                default:
                    self.errorMessage = "Login failed. Verify credintials and try again."
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

