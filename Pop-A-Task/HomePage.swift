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

        @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
        @State private var showMenu = false
        let menu = ["Home", "Profile", "Groups", "Tasks", "Help", "Logout"]
        @ObservedObject var userData = UserData()

    var body: some View {
            NavigationView {
                ZStack {
                    if showMenu {
                        DrawerView(menu: menu, username: userData.userName ?? "no name HP", isLoggedIn: .constant(false))
                            .transition(.slide)
                            .zIndex(1)
//                            .overlay(Color.black.opacity(0.5))
                    }

                    VStack {
                        if userData.userName != nil {
                            Text("Welcome, \(userData.userName!)")
                        } else {
                            Text("Loading...")
                        }
                    }
                }
                .edgesIgnoringSafeArea(.bottom)
                .navigationBarItems(leading:
                    Button(action: { self.showMenu.toggle() }) {
                        Image(systemName: "person.circle")
                            .imageScale(.large)
                    }
                )
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
            print("User not found hp")
        }

        }
    }}
struct HomeView_Previews: PreviewProvider{
    static var previews: some View{
        HomeView()
    }
}
