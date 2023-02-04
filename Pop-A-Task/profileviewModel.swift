//
//  profileviewModel.swift
//  Pop-A-Task
//
//  Created by manpreet Kaur on 2023-02-04.
//

import Foundation

/// ViewModel for SandwichesListView
final class SandwichesListViewModel: ObservableObject {
    //MARK: Observable propreties
    @ObservedObject var store: SandwichStore
    @Published var navTitle: String = ""
    @Published var searchTerm: String = ""
    @Published var searchResults: [Sandwich] = []
    
    /// Computed property to display data
    var listData: [Sandwich] {
        return searchTerm.isEmpty ? store.sandwiches : searchResults
    }
    /// Show total count of sandwiches
    var displayCount: String {
        "\(listData.count) Sandwiches"
    }
    
    /// Inititalizer
    /// - Parameters:
    ///   - store: SandwichStore
    ///   - navTitle: String
    init(store: SandwichStore = SandwichStore.testSandwichStore, navTitle: String = "Sandwiches") {
        self.store = store
        self.navTitle = navTitle
    }

    /// To filter result using search
    func filterSearchResults() {
        searchResults = store.sandwiches.filter({ $0.name.localizedCaseInsensitiveContains(searchTerm)})
    }
    
    /// Adds given sandwich to SandwichStore
    /// - Parameter sandwich: Sandwich
    func makeSandwich(sandwich: Sandwich) {
        store.sandwiches.append(sandwich)
    }
    
    /// Removes sandwich for SandwichStore at given index
    /// - Parameter offsets: Indexset
    func deleteSandwiches(offsets: IndexSet) {
        store.sandwiches.remove(atOffsets: offsets)
    }
    
    /// Moves sandwich in Sandwich store
    /// - Parameters:
    ///   - from: IndexSet
    ///   - to: Int
    func moveSandwiches(from: IndexSet, to: Int) {
        store.sandwiches.move(fromOffsets: from, toOffset: to)
    }
}

