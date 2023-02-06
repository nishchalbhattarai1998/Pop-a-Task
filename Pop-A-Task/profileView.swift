//
//  profileView.swift
//  Pop-A-Task
//
//  Created by manpreet Kaur on 2023-02-04.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth


struct userprofileView: View {
    
    let menuItems = ["Home", "Profile", "Groups", "Tasks", "Help"]
        
        var body: some View {
            NavigationView {
                List(menuItems, id: \.self) { item in
                    NavigationLink(destination: self.destination(for: item)) {
                        Text(item)
                    }
                }
            }
        }
        
        private func destination(for item: String) -> AnyView {
            switch item {
            case "Home":
                return AnyView(HomeView())
            case "Profile":
                return AnyView(userDetails())
            case "Settings":
                return AnyView(HomeView())
            case "Notifications":
                return AnyView(HomeView())
            case "Help":
                return AnyView(HomeView())
            default:
                return AnyView(EmptyView())
            }
        }
    }

//    let profileMenu = ["User Details", "Add Group", "Add Task", "Members", "Help", "Log Out"]
//
//    var body: some View {
//        NavigationView{
//            List(profileMenu, id: \.self) { profileMenu in
//                NavigationLink(destination: EmptyView()){
//                    HStack {
//                        Image(systemName: "checkmark.circle")
//                            .resizable()
//                            .foregroundColor(Color("AccentColor"))
//                            .frame(width: 30, height: 30)
//                            .padding(20)
//                        Text(profileMenu)
//                            .font(.title3)
//                            .fontWeight(.semibold)
//                            .foregroundColor(Color.green)
//                    }
//                    .onTapGesture {
//                        print("You tapped \(profileMenu)")
//                        if profileMenu == "Log Out"{
//                            print("Please set the logout function")
//                        }
//                        if profileMenu == "User Details"{
//                            NavigationLink(destination: userDetails()) {
//                                EmptyView()
//                            }
//                        }
//                    }
//                }
//            }
//        }
//        NavigationView{
//            List(profileMenu, id: \.self) { profileMenu in
//                HStack {
//                    Image(systemName: "checkmark.circle")
//                        .resizable()
//                        .foregroundColor(Color("AccentColor"))
//                        .frame(width: 30, height: 30)
//                        .padding(20)
//                    Text(profileMenu)
//                        .font(.title3)
//                        .fontWeight(.semibold)
//                        .foregroundColor(Color.green)
//                }
//                .onTapGesture {
//                    print("You tapped \(profileMenu)")
//                    if profileMenu == "Log Out"{
//                        print("Please set the logout function")
//                    }
//                    if profileMenu == "User Details"{
//                        NavigationLink(destination: userDetails()) {
//                            EmptyView()
//                        }
//                    }
//                }
//            }
//        }

//    }


struct userprofileView_Previews: PreviewProvider {
    static var previews: some View {
        userprofileView()
    }
}

