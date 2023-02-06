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
import UIKit

struct DrawerView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let menu: [String]
    let username: String

    var body: some View {
        ZStack {
            VStack {
                Text(username)
                    .padding()
                    .font(.title)

                List(menu, id: \.self) { item in
                    NavigationLink(destination: (self.destination(for: item).navigationBarBackButtonHidden(true))) {
                        Text(item)
                    }
                }
                .listStyle(SidebarListStyle())
                .padding()
            }
            .background(Blur(style: .systemMaterial).edgesIgnoringSafeArea(.all))
        }
    }

    private func destination(for item: String) -> some View {
        switch item {
        case "Home":
            return AnyView(HomeView())
        case "Profile":
            return AnyView(userDetails())
        case "Groups":
            return AnyView(HomeView())
        case "Tasks":
            return AnyView(HomeView())
        case "Help":
            return AnyView(HomeView())
        case "Logout":
            return AnyView(LoginView(isLoggedIn: Binding.constant(false)))
        default:
            return AnyView(EmptyView())
        }
    }
}

struct Blur: UIViewRepresentable {
    let style: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}



//struct ContentView: View {
//    @State private var showMenu = false
//
//    let menu = ["Home", "Profile", "Settings", "Help", "Logout"]
//
//    var body: some View {
//        ZStack {
//            NavigationView {
//                ZStack(alignment: .leading) {
//                    List {
//                        ForEach(menu, id: \.self) { item in
//                            NavigationLink(destination: self.destination(for: item)) {
//                                Text(item)
//                            }
//                        }
//                    }
//                    .listStyle(SidebarListStyle())
//                }
//                .frame(width: 250)
//                .shadow(radius: 20)
//                .padding(.top, 60)
//                .background(Color.white)
//                .offset(x: showMenu ? 0 : -250)
//                .animation(.default)
//
//                HomeScreen()
//            }
//
//            HStack {
//                Button(action: { self.showMenu.toggle() }) {
//                    Image(systemName: "person.crop.circle")
//                        .font(.system(size: 25))
//                        .foregroundColor(.black)
//                }
//                .padding(.top, 30)
//                .padding(.leading, 20)
//            }
//        }
//    }
//
//    private func destination(for item: String) -> some View {
//        switch item {
//        case "Home":
//            return AnyView(HomeScreen())
//        case "Profile":
//            return AnyView(ProfileScreen())
//        case "Settings":
//            return AnyView(SettingsScreen())
//        case "Help":
//            return AnyView(HelpScreen())
//        case "Logout":
//            return AnyView(Text("Logout Screen"))
//        default:
//            return AnyView(Text("Unknown Screen"))
//        }
//    }
//}

//struct userprofileView: View {
//    @State private var showMenu = false
//
//    let menu = ["Home", "Profile", "Settings", "Help", "Logout"]
//
//    var body: some View {
//        NavigationView {
//            ZStack {
//                if !showMenu {
//                    HomeView()
//                } else {
//                    List(menu, id: \.self) { item in
//                        Button(action: {
//                            self.showMenu.toggle()
//                            self.destination(for: item)
//                        }) {
//                            Text(item)
//                        }
//                    }
//                    .frame(width: 200)
//                    .background(Color.white)
//                    .cornerRadius(30)
//                    .shadow(radius: 20)
//                }
//            }
//
//            .navigationBarItems(leading:
//                Button(action: {
//                    self.showMenu.toggle()
//                }) {
//                    Image(systemName: "person.circle")
//                        .imageScale(.large)
//                }
//            )
//        }
//    }
//
//    private func destination(for item: String) -> some View {
//        switch item {
//        case "Home":
//            return AnyView(HomeView())
//        case "Profile":
//            return AnyView(ProfileScreen())
//        case "Settings":
//            return AnyView(SettingsScreen())
//        case "Help":
//            return AnyView(HelpScreen())
//        case "Logout":
//            return AnyView(LogoutScreen())
//        default:
//            return AnyView(Text(""))
//        }
//    }
//}
//
//struct HomeScreen: View {
//    var body: some View {
//        Text("Home Screen")
//    }
//}
//
//struct ProfileScreen: View {
//    var body: some View {
//        Text("Profile Screen")
//    }
//}
//
//struct SettingsScreen: View {
//    var body: some View {
//        Text("Settings Screen")
//    }
//}
//
//struct HelpScreen: View {
//    var body: some View {
//        Text("Help Screen")
//    }
//}
//
//struct LogoutScreen: View {
//    var body: some View {
//        Text("Logout Screen")
//    }
//}


//struct userprofileView: View {
//    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
//
//    let menuItems = ["Home", "Profile", "Groups", "Tasks", "Help"]
//
//        var body: some View {
//            NavigationView {
//                List(menuItems, id: \.self) { item in
//                    NavigationLink(destination: self.destination(for: item)) {
//                        Text(item)
//
//                    }
//                }
//            }
//        }
//
//        private func destination(for item: String) -> AnyView {
//            switch item {
//            case "Home":
//                presentationMode.wrappedValue.dismiss()
//                return AnyView(HomeView())
//            case "Profile":
//                return AnyView(userDetails())
//            case "Settings":
//                return AnyView(HomeView())
//            case "Notifications":
//                return AnyView(HomeView())
//            case "Help":
//                return AnyView(HomeView())
//            default:
//                return AnyView(EmptyView())
//            }
//        }
//    }

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


struct DrawerView_Previews: PreviewProvider {
    static var previews: some View {
        DrawerView(menu: ["Home", "Profile", "Groups", "Tasks", "Help", "Logout"], username: "")
    }
}

