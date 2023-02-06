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
    @Binding var isLoggedIn: Bool

        var body: some View {
            Group {
                if isLoggedIn {
                    Home()
                        .onAppear {
                            print("isLoggedIn if state home: \(self.isLoggedIn)")
                        }
                } else {
                    LoginView(isLoggedIn: $isLoggedIn)
                        .onAppear {
                            print("isLoggedIn else state home: \(self.isLoggedIn)")
                        }
                }
            }
        }
}


struct Home: View {
    
    @State private var showMenu = false
    let menu = ["Home", "Profile", "Groups", "Tasks", "Help", "Logout"]
    @ObservedObject var userData = UserData()
   
    
    var body: some View {
        NavigationView {
            ZStack {
                if showMenu {
                    DrawerView(menu: menu, username: userData.userName ?? "Loading", isLoggedIn: .constant(true), userData: UserData())
                        .transition(.slide)
                        .zIndex(1)
                    //                            .overlay(Color.black.opacity(0.5))
                }
                
                VStack {
                    if userData.userName != nil {
                        Text("Welcome, \(userData.userName!)")
                        Text("No group no task.")
                        
                    } else {
                        Text("Edit or update user details!!")
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
}

struct HomeView_Previews: PreviewProvider{
    static var previews: some View{
        HomeView(isLoggedIn: .constant(true))
    }
}
