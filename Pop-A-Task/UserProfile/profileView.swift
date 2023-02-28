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
    @Binding var isLoggedIn: Bool
    @Binding var selectedTab: Int
    @ObservedObject var userData: UserData
    let username: String

    var body: some View {
        VStack {
            Text(username)
                .padding()
                .font(.title)

            List {
                NavigationLink(destination: userDetails(userData: UserData())) {
                    Text("Profile")
                }
                NavigationLink(destination: HelpView()) {
                    Text("Help")
                }
                Button(action: {
                    logout()
                    print("isLoggedIn state at logout tap: \(self.isLoggedIn)")
                }, label: {
                    Text("Logout")
                })
            }
        }
    }

    private func logout() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
//            self.isLoggedIn = false
            print("isLoggedIn if state inside logout function: \(self.isLoggedIn)")
        }
//        self.isLoggedIn = false
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
        profileView(
            isLoggedIn: .constant(false), selectedTab: .constant(0),
            userData: UserData(),
            username: "Loading"
        )
    }
}
