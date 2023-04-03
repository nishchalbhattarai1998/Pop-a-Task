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


struct profileView: View {
    @State private var isShowingLogoutConfirmation = false
    @Binding var isLoggedIn: Bool
    @Binding var selectedTab: Int
    @ObservedObject var userData: UserData
    let username: String
    @AppStorage("isDarkMode") private var isDarkMode = false

    var body: some View {
        NavigationView{
            VStack {
                Text(username)
                    .padding()
                    .font(.title)
                
                List {
                    NavigationLink(destination: userDetails(userData: UserData()))  {
                        Label("Profile", systemImage: "person")
                    }
                    NavigationLink(destination: HelpView()) {
                        Label("Help", systemImage: "questionmark.circle")
                    }
                    Button(action: {
                        self.isShowingLogoutConfirmation = true
                    }) {
                        Label("Logout", systemImage: "power")
                    }
                    .alert(isPresented: $isShowingLogoutConfirmation) {
                        Alert(
                            title: Text("Logout"),
                            message: Text("Are you sure you want to log out?"),
                            primaryButton: .default(Text("Log out"), action: {
                                logout()
                            }),
                            secondaryButton: .cancel()
                        )
                    }
                    Button(action: {
                        isDarkMode.toggle()
                    }) {
                        Label("Toggle Dark Mode", systemImage: isDarkMode ? "sun.max" : "moon")
                    }
                }
                .preferredColorScheme(isDarkMode ? .dark : .light) // Set preferred color scheme based on isDarkMode
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private func logout() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
            print("isLoggedIn if state inside logout function: \(self.isLoggedIn)")
        }
        DispatchQueue.main.async {
            self.isLoggedIn = false
            self.selectedTab = 0
            print("isLoggedIn if state inside logout function manual change: \(self.selectedTab)")
            print("isLoggedIn if state inside logout function manual change: \(self.isLoggedIn)")
        }
    }
}


struct profileView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            profileView(
                isLoggedIn: .constant(false), selectedTab: .constant(0),
                userData: UserData(),
                username: "Loading"
            )
            .preferredColorScheme(.light) // Preview in light mode
            
            profileView(
                isLoggedIn: .constant(false), selectedTab: .constant(0),
                userData: UserData(),
                username: "Loading"
            )
            .preferredColorScheme(.dark) // Preview in dark mode
        }
    }
}
