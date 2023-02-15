//
//  GroupView.swift
//  Pop-A-Task
//
//  Created by Charles Roy on 2023-02-06.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct GroupView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var isLoggedIn: Bool

        var body: some View {
            Group {
                if isLoggedIn {
                    GroupV()
                        .onAppear {
                            print("isLoggedIn if state group: \(self.isLoggedIn)")
                        }
                } else {
                    LoginView(isLoggedIn: $isLoggedIn)
                        .onAppear {
                            print("isLoggedIn else state group: \(self.isLoggedIn)")
                        }
                }
            }
        }
}


struct GroupV: View {
    
    @State private var showMenu = false
    let menu = ["Home", "Profile", "Groups", "Tasks", "Help", "Logout"]
    @ObservedObject var userData = UserData()
   
    
    var body: some View {
        NavigationView {
            ZStack {
                HStack{
                    if showMenu {
                        DrawerView(menu: menu, username: userData.userName ?? "Loading", isLoggedIn: .constant(true), userData: UserData())
                            .transition(.slide)
                            .zIndex(1)
                    }
                    Spacer()
                    Button(action: {
                    // Perform action when button is pressed
                    }) {
                        Image(systemName: "plus")
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50)
                        .background(Color.green)
                        .clipShape(Circle())
                        .padding(.bottom, 770)
                        .padding(.trailing, 20)
                    }
                }
                
                
                VStack {

                        Text("Your group will appare here")

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

struct GroupView_Previews: PreviewProvider{
    static var previews: some View{
        GroupView(isLoggedIn: .constant(true))
    }
}

