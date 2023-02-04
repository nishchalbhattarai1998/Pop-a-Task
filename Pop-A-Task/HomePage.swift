//
//  HomePage.swift
//  Pop-A-Task
//
//  Created by nishchal bhattarai on 2023-02-04.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @State private var showProfile = false
    
    var body: some View {
        ZStack {
            Button(action: {
                self.showProfile.toggle()
            }) {
                Image(systemName: "person.crop.circle")
                    .font(.system(size: 40))
            }
            .padding(.top, -387.0)
            .padding(.leading, 321)
            
            if showProfile {
//                HStack {
//                    Spacer()
                    
                    VStack {
                        HStack {
                            Text("Profile Menu")
                                .font(.title)
                                .foregroundColor(Color.white)
                            
                            Spacer()
                            Spacer()
                            
                            Button(action: {
                                self.showProfile.toggle()
                            }) {
                                Image(systemName: "person.crop.circle")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 40))
                            }
                        }
                        .padding()
                        

                        userprofileView()
                    }
                    .background(Color("AccentColor"))
                    .cornerRadius(15)
                    .shadow(radius: 15)
                    .padding()
                    
//                }
                .transition(.move(edge: .trailing))
            }
        }
    }
}


struct HomeView_Previews: PreviewProvider{
    static var previews: some View{
        HomeView()
    }
}
