//
//  HomePage.swift
//  Pop-A-Task
//
//  Created by nishchal bhattarai on 2023-02-04.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct HomeView: View {

    @StateObject var viewModel = GroupViewModel()
    @State private var showMenu = false
    @ObservedObject var userData = UserData()
   
    
    var body: some View {
        NavigationView {
                
                VStack {
                    if userData.userName != nil {
                        Text("Welcome, \(userData.userName!)")
                        if GroupStore.testStore.groups.count > 0 {
                            Text("You have \(viewModel.filteredData.count) groups and 0 Tasks")
                        } else {
                            Text("No group no task.")
                        }
                        
                    } else {
                        Text("Edit or update user details!!")
                    }
                }
            }
        }
    }


struct HomeView_Previews: PreviewProvider{
    static var previews: some View{
        HomeView()
    }
}
