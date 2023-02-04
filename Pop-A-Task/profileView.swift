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

    let profileMenu = ["User Details", "User Picture", "Message", "Resate Password", "Help", "Log Out"]
    
    var body: some View {

        List(profileMenu, id: \.self) { profileMenu in
            HStack {
                Image("")
                    .resizable()
                    .frame(width: 50, height: 50)
                Text(profileMenu)
            }
            .onTapGesture {
                print("You tapped \(profileMenu)")
            }
        }
    }
}

struct userprofileView_Previews: PreviewProvider {
    static var previews: some View {
        userprofileView()
    }
}

