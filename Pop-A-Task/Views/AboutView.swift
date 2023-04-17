//
//  HelpView.swift
//  Pop-A-Task
//
//  Created by Charles Roy on 2023-02-06.
//

import Foundation
import SwiftUI

struct AboutView: View {
    @State private var showMenu = false
    @ObservedObject var userData = UserData()
    
    
    var body: some View {
        NavigationView {
            Form {
                VStack {
                    Image("splashLogo")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .padding(.horizontal)
                    
                    Text("Pop A Task")
                        .fontWeight(.heavy)
                        .foregroundColor(.green)
                        .font(.largeTitle)
                    
                    Text("Welcome \(userData.userName ?? "") to Pop A Task. Pop A Task is a simple task-reminder tool that lets users to create or modify tasks, discuss the work that needs to be done, and reach the milestone in a set period of time. This application can be used at home, in a small group, or in a small business.")
                        .multilineTextAlignment(.leading)
                        .textCase(.lowercase) // Justify-like effect
                        .padding(.bottom, 50)
                        .padding(20)
                        .frame(width: 400.0)
                }
                
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            
            .navigationBarTitle("About Pop A Task")
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
    
}

struct HelpView_Previews: PreviewProvider{
    static var previews: some View{
        AboutView()
    }
}
