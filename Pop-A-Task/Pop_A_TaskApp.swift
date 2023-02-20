//
//  Pop_A_TaskApp.swift
//  Pop-A-Task
//
//  Created by nishchal bhattarai on 2023-01-16.
//

import SwiftUI
import Firebase

@main
struct Pop_A_TaskApp: App {
    init(){
        FirebaseApp.configure()
    }
    @StateObject private var store = GroupStore.testStore
    var body: some Scene {
        WindowGroup {
            ContentView(categories: .constant(["Household", "Sports", "Grocery", "Utility"]), status: .constant(["To Do", "In Progress", "Done", "Cancelled"]), priority: .constant(["High", "Medium", "Low"]))
        }
    }
}
