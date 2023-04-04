//
//  SplashView.swift
//  Pop-A-Task
//
//  Created by Charles Roy on 2023-02-21.
//

import SwiftUI

struct SplashView: View {
    @Binding var isLoggedIn: Bool
    @State private var selectedTab = 0
    @State private var isActive = false

    var body: some View {
        ZStack {
            Color(red: 0.24, green: 0.25, blue: 0.28)
                .ignoresSafeArea()
            VStack {
                Image("splashLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 400, height: 400)
                Text("Pop A Task")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                Spacer()
                HStack {
                    Text("Loading tasks...")
                        .foregroundColor(.white)
                        .font(.system(size: 14))
                        .padding(.top, 8)
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))

                }
                .padding(.bottom, 32)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.isActive = true
            }
        }
        .fullScreenCover(isPresented: $isActive) {
            tabView(isLoggedIn: $isLoggedIn,
                userData: UserData(),
                selectedTab: $selectedTab)
        }
    }
}

struct SplashView_Previews: PreviewProvider{
    static var previews: some View{
        SplashView(isLoggedIn: .constant(true))
    }
}
