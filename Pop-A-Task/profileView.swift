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
    @Binding var isLoggedIn: Bool
    @ObservedObject var userData: UserData

    var body: some View {
        ZStack {
            VStack {
                Text(username)
                    .padding()
                    .font(.title)

                List(menu, id: \.self) { item in
                    NavigationLink(destination: (self.destination(for: item).navigationBarBackButtonHidden(true ))) {
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
            print("isLoggedIn state at m h t: \(self.isLoggedIn)")
            return AnyView(HomeView(isLoggedIn: .constant(true)))
        case "Profile":
            print("isLoggedIn state at m p t:  \(self.isLoggedIn)")
            return AnyView(userDetails(isLoggedIn: .constant(true)))
        case "Groups":
            print("isLoggedIn state at m g t: \(self.isLoggedIn)")
            return AnyView(HomeView(isLoggedIn: .constant(true)))
        case "Tasks":
            print("isLoggedIn state at m t t: \(self.isLoggedIn)")
            return AnyView(taskView(isLoggedIn: .constant(true)))
        case "Help":
            print("isLoggedIn state at m h t: \(self.isLoggedIn)")
            return AnyView(HomeView(isLoggedIn: .constant(true)))
        case "Logout":
            onTapGesture {
                logout()
                print("isLoggedIn state at logout tap: \(self.isLoggedIn)")
            }
            
            return AnyView(ContentView())
        default:
            return AnyView(EmptyView())
        }
    }

    private func logout() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
            self.isLoggedIn = false
            print("isLoggedIn if state inside logout function: \(self.isLoggedIn)")
        }
        self.isLoggedIn = false
        DispatchQueue.main.async {
            self.isLoggedIn = false
            print("isLoggedIn if state inside logout function manual change: \(self.isLoggedIn)")
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
struct DrawerView_Previews: PreviewProvider {
    static var previews: some View {
        DrawerView(menu: ["Home", "Profile", "Groups", "Tasks", "Help", "Logout"], username: "", isLoggedIn: .constant(false), userData: UserData())
    }
}

