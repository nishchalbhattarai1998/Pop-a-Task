//
//  tabView.swift
//  Pop-A-Task
//
//  Created by Charles Roy on 2023-02-27.
//

import Foundation
import SwiftUI

struct tabView: View {
    @Binding var categories: [String]
    @Binding var status: [String]
    @Binding var priority: [String]
    @Binding var isLoggedIn: Bool
    @ObservedObject var userData: UserData
    @Binding var selectedTab: Int
//    let menu = ["Profile", "Help", "Logout"]
    //    @State private var showAddMenu = false
    @State private var showAddMenu = false
    @State private var showBottomSheet = false
    @State private var selectedItem: String = ""
    @State private var isShowingMenu = false
    @State private var plusButtonScale: CGFloat = 1.0
    var body: some View {
        ZStack{
            SwiftUI.TabView(selection: $selectedTab) {
                HomeView()
                    .tabItem {
                        Image(systemName: "house.circle.fill")
                        Text("Home")
                    }
                    .tag(0)
                
                taskView()
                    .tabItem {
                        Image(systemName: "tray.circle.fill")
                        Text("Task")
                    }
                    .tag(1)
                Spacer()
                GroupView(viewModel: GroupViewModel())
                    .tabItem {
                        Image(systemName: "person.2.circle")
                        Text("Group")
                    }
                    .tag(2)
                
                profileView(
                    isLoggedIn: $isLoggedIn, selectedTab: $selectedTab,
                           userData: UserData(),
                           username: userData.userName ?? "Loading")
                .tabItem {
                    Image(systemName: "gear.circle.fill")
                    Text("Setting")
                }
                .tag(3)
            }

                
                VStack {
                    Spacer()
                    
                    HStack {
//                        Spacer()
                        
                        Button(action: {
                            withAnimation (.easeInOut){
                                isShowingMenu.toggle()
                            }
                        }, label: {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .foregroundColor(.green)
                                .frame(width: isShowingMenu ? 50 : 40, height: isShowingMenu ? 50 : 40)
                        })
                    }
                    .padding(.bottom, 10)
                }
                
                if isShowingMenu {
                    Color.black.opacity(0.5)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation {
                                isShowingMenu.toggle()
                            }
                        }
                    
                    VStack(spacing: 1) {
                        Button(action: {
                            // Handle "New Task" action here
                            print("add task function here")
                            withAnimation {
                                isShowingMenu.toggle()
                            }
                        }, label: {
                            HStack(spacing: 10) {
                                Image(systemName: "square.and.pencil")
                                    .foregroundColor(.blue)
                                
                                Text("New Task")
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                        })
                        Divider().background(Color.gray)
                        Button(action: {
                            // Handle "New Group" action here
                            print("add group function here")
                            withAnimation {
                                isShowingMenu.toggle()
                            }
                        }, label: {
                            HStack(spacing: 10) {
                                Image(systemName: "person.2.square.stack")
                                    .foregroundColor(.blue)
                                
                                Text("New Group")
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                        })
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(radius: 10)
                    .padding(.horizontal, 30)
                    .padding(.bottom, 30)
                    .transition(.move(edge: .bottom))
                    .zIndex(2)
                }
            
        }
    }}
struct tabView_Previews: PreviewProvider {
    static var previews: some View {
        tabView(categories: .constant(["Household", "Sports", "Grocery", "Utility"]),
                status: .constant(["To Do", "In Progress", "Done", "Cancelled"]),
                priority: .constant(["High", "Medium", "Low"]),
                isLoggedIn: .constant(true),
                userData: UserData(),
                selectedTab: Binding.constant(0))
    }
}

