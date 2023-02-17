//
//  AddMemberView.swift
//  Pop-A-Task
//
//  Created by Charles Roy on 2023-02-17.
//

import Foundation
import SwiftUI

struct AddMemberView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var members: [String]
    @State private var newMemberName = ""

    var body: some View {
        NavigationView {
            VStack {
                TextField("New member name", text: $newMemberName)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                Button(action: {
                    members.append(newMemberName)
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Add Member")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()

                Spacer()
            }
            .navigationTitle("Add Member")
        }
    }
}
