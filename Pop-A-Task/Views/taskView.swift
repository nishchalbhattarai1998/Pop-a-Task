
//  taskView.swift
//  Pop-A-Task
//
//  Created by nishchal bhattarai on 2023-02-06.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct taskView: View {
    @State private var isTaskModal = false
    @State private var isTaskSetting = false
    @State private var showMenu = false
    let menu = ["Home", "Profile", "Groups", "Tasks", "Help", "Logout"]
    @ObservedObject var userData = UserData()
    @Binding var isLoggedIn: Bool
    @Binding var categories: [String]
    @Binding var status: [String]
    @Binding var priority: [String]
    
    var body: some View {
        NavigationView {
            ZStack {
                if showMenu {
                    DrawerView(
                               categories: $categories,
                               status: $status,
                               priority: $priority,
                               menu: menu,
                               username: userData.userName ?? "Loading",
                               isLoggedIn: .constant(true), userData: UserData())
                        .transition(.slide)
                        .zIndex(1)
                }
                
                VStack {
                    Text("Welcome to task view")
                        .toolbar {
                            HStack {
                                Button("Add Task") {
                                    isTaskModal = true
                                }
                                .sheet(isPresented: $isTaskModal) {
                                    AddTaskModalView(isTaskModal: $isTaskModal, categories: $categories, status: $status, priority: $priority)
                                }
                                
                                Button("Task Setting") {
                                    isTaskSetting = true
                                }
                                .sheet(isPresented: $isTaskSetting) {
                                    TaskSettingsModal(isTaskSetting: $isTaskSetting)
                                }
                            }
                        }
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarItems(leading:
                Button(action: { self.showMenu.toggle() }) {
                    Image(systemName: "person.circle")
                        .imageScale(.large)
                }
            )
        }
    }
}

struct taskView_Previews: PreviewProvider {
    static var previews: some View {
        taskView(isLoggedIn: .constant(true),
                 categories: .constant(["Category1", "Category2", "Category3"]),
                 status: .constant(["Status1", "Status2", "Status3"]),
                 priority: .constant(["Priority1", "Priority2", "Priority3"]))
    }
}
