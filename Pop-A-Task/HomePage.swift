//
//  HomePage.swift
//  Pop-A-Task
//
//  Created by nishchal bhattarai on 2023-02-04.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct HomeView: View {
    @State private var showProfile = false
//        @State private var userUUID: String?
    @ObservedObject private var userData = UserData()
    
    var body: some View {

        ZStack {
            Button(action: {
                self.showProfile.toggle()
            }) {
                Image(systemName: "person.crop.circle")
                    .font(.system(size: 40))
            }
            .padding(.top, -387.0)
            .padding(.leading, 321)
            
            if showProfile {
                //                HStack {
                //                    Spacer()
                
                VStack {
                    HStack {
                        Text("\(userData.userName!)")
                            .font(.title)
                            .foregroundColor(Color.white)
                        
                        Spacer()
                        Spacer()
                        
                        Button(action: {
                            self.showProfile.toggle()
                        }) {
                            Image(systemName: "person.crop.circle")
                                .foregroundColor(Color.white)
                                .font(.system(size: 40))
                        }
                    }
                    .padding()
                    
                    
                    userprofileView()
                }
                .background(Color("AccentColor"))
                .cornerRadius(15)
                .shadow(radius: 15)
                .padding()
                
                //                }
                .transition(.move(edge: .trailing))
            }
        }
        
        if userData.userName != nil {
            Text("Welcome, \(userData.userName!)")
        } else {
            Text("Loading...")
        }
        
    }

    class UserData: ObservableObject {
        @Published var userName: String?
        init() {
        if Auth.auth().currentUser != nil {
            
                let userID = Auth.auth().currentUser?.uid ?? ""
                print("\(userID)")
                let db = Firestore.firestore()
                db.collection("users").document(userID).addSnapshotListener { documentSnapshot, error in
                    guard let document = documentSnapshot else {
                        print("Error fetching document: \(error!)")
                        return
                    }
                    self.userName = document.data()?["name"] as? String
                }
        } else {
            print("User not found")
        }

        }
    }}
struct HomeView_Previews: PreviewProvider{
    static var previews: some View{
        HomeView()
    }
}
