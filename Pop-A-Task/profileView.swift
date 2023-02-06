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
            logout()
            return AnyView(LoginView(isLoggedIn: $isLoggedIn))
        default:
            return AnyView(EmptyView())
        }
    }

    private func logout() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }

        isLoggedIn = false
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
        DrawerView(menu: ["Home", "Profile", "Groups", "Tasks", "Help", "Logout"], username: "", isLoggedIn: .constant(false))
    }
}

