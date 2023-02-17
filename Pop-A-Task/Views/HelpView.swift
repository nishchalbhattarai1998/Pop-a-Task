//
//  HelpView.swift
//  Pop-A-Task
//
//  Created by Charles Roy on 2023-02-06.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct HelpView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var isLoggedIn: Bool

        var body: some View {
            Group {
                if isLoggedIn {
                    HelpV()
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


struct HelpV: View {
    
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
                }
                
            VStack {
                Image(systemName: "lines.measurement.horizontal")
                    .padding(.top, 0.0)
                    .imageScale(.large)
                    .foregroundColor(.green)
                    .font(.largeTitle)
                
                Text("Pop A Task").fontWeight(.heavy)
                    .foregroundColor(.green)
                    .padding(.bottom, 300)
                    .font(.largeTitle)
                Text("Welcome \(userData.userName ?? "") to Pop A Task. Pop A Task is a simple task-reminder tool that lets users to create or modify tasks, discuss the work that needs to be done, and reach the milestone in a set period of time. This application can be used at home, in a small group, or in a small business.").multilineTextAlignment(.leading).padding(.bottom, 50)
                    .frame(width: 400.0)

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

struct HelpView_Previews: PreviewProvider{
    static var previews: some View{
        HelpView(isLoggedIn: .constant(true))
    }
}
