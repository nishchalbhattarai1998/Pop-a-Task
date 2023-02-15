//
//  GroupStore.swift
//  Pop-A-Task
//
//  Created by Sangam Gurung on 2023-02-14.
//

import Foundation

final class GroupStore : ObservableObject {
    @Published var groups: [Groups]
    
    init(groups: [Groups] = mockData) {
        self.groups = groups
    }
}

extension GroupStore {
    static var mockData = [
        Groups(groupName: "Home Group",
                isFavorite: true),
        Groups(groupName: "School Group",
                isFavorite: false),
        Groups(groupName: "Sports Group",
                isFavorite: true),
        Groups(groupName: "Other Group",
                isFavorite: false),
    ]

    static var testStore: GroupStore = GroupStore(groups: mockData)
}

