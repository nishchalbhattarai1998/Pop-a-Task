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
    @AppStorage("isDarkMode") private var isDarkMode = false // Store user's preference for color scheme
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(isDarkMode ? .dark : .light) // Set preferred color scheme based on isDarkMode
        }
    }
}
