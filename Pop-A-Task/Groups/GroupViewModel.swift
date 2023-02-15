//
//  GroupViewModel.swift
//  Pop-A-Task
//
//  Created by Sangam Gurung on 2023-02-14.
//

import Foundation
import SwiftUI
final class GroupViewModel: ObservableObject {
   
    @ObservedObject var store: GroupStore
    @Published var navTitle: String = ""
    @Published var searchTerm: String = ""
    @Published var searchResults: [Groups] = []
    
    private var initialContact: [Groups]
    
    
    var listData: [Groups] {
        return searchTerm.isEmpty ? store.groups : searchResults
    }
    
    var displayCount: String {
        "\(listData.count) Groups"
    }
    
   
    init(store: GroupStore = GroupStore.testStore, navTitle: String = "Groups") {
        self.store = store
        self.initialContact = GroupStore.mockData
        self.navTitle = navTitle
        
    }

    
    func filterSearchResults() {
        searchResults = store.groups.filter({ $0.groupName.localizedCaseInsensitiveContains(searchTerm)})
    }
    
    
   
    func makeContact(contact: Groups) {
        store.groups.append(contact)
    }
    
    
    func deleteContact(offsets: IndexSet) {
        store.groups.remove(atOffsets: offsets)
    }
    
   
    func moveContacts(from: IndexSet, to: Int) {
        store.groups.move(fromOffsets: from, toOffset: to)
    }
    func resetData(){
        store.groups = initialContact
    }
}

    



