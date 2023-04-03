//
//  ResetPassword.swift
//  Pop-A-Task
//
//  Created by Sangam Gurung on 2023-04-02.
//
import SwiftUI
import FirebaseAuth
struct ResetPasswordView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var email = ""

    var body: some View {
        VStack {
            Text("Reset Password")
                .font(.title)
                .padding()

            Text("Enter your email address and we'll send you a link to reset your password.")
                .font(.subheadline)
                .padding()

            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                resetPassword()
            }, label: {
                Text("Reset Password")
            })
            .padding()
        }
    }

    func resetPassword() {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if error != nil {
                // handle error
            } else {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}

