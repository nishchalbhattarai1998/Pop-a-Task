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
            }
        }
    }
}

struct userprofileView_Previews: PreviewProvider {
    static var previews: some View {
        userprofileView()
    }
}

