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
//    @Environment(\.drawerState) var drawerState

    let profileMenu = ["User Details", "Add Group", "Add Task", "Members", "Help", "Log Out"]
    
    var body: some View {

        List(profileMenu, id: \.self) { profileMenu in
            HStack {
                Image(systemName: "checkmark.circle")
                    .resizable()
                    .foregroundColor(Color("AccentColor"))
                    .frame(width: 30, height: 30)
                    .padding(20)
                Text(profileMenu)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.green)
            }
            .onTapGesture {
                print("You tapped \(profileMenu)")
                if profileMenu == "Log Out"{
                    print("Please set the logout function")
                }
            }
        }
    }
}

struct userprofileView_Previews: PreviewProvider {
    static var previews: some View {
        userprofileView()
    }
}

