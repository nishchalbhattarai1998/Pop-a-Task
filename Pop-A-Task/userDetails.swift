//
//  userDetails.swift
//  Pop-A-Task
//
//  Created by manpreet Kaur on 2023-02-05.
//

import Foundation
import SwiftUI

struct userDetails: View {
    @State private var name: String = "John Doe"
        @State private var email: String = "john.doe@example.com"
        @State private var isEditing = false

        var body: some View {
            VStack {
                if isEditing {
                    Form {
                        Section {
                            TextField("Name", text: $name)
                            TextField("Email", text: $email)
                        }
                    }
                } else {
                    Form {
                        Section {
                            Text("Name: \(name)")
                            Text("Email: \(email)")
                        }
                    }
                }
                HStack {
                    if isEditing {
                        Button("Save") {
                            self.isEditing = false
                        }
                    } else {
                        Button("Edit") {
                            self.isEditing = true
                        }
                    }
                }
            }
        }
    }


struct userDetails_Previews: PreviewProvider {
    static var previews: some View {
        userDetails()
    }
}
