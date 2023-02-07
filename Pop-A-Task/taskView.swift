//
//  taskView.swift
//  Pop-A-Task
//
//  Created by nishchal bhattarai on 2023-02-06.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct taskView: View {
    @State private var showMenu = false
    let menu = ["Home", "Profile", "Groups", "Tasks", "Help", "Logout"]
    @ObservedObject var userData = UserData()
    @Binding var isLoggedIn: Bool
    var body: some View {
        NavigationView {
            ZStack {
                if showMenu {
                    DrawerView(menu: menu, username: userData.userName ?? "Loading", isLoggedIn: .constant(true), userData: UserData())
                        .transition(.slide)
                        .zIndex(1)
                }
                
                VStack {
                    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                    Text("Welcome to task view")
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
    }}

struct taskView_Previews: PreviewProvider {
    static var previews: some View {
        taskView(isLoggedIn: .constant(true))
    }
}
