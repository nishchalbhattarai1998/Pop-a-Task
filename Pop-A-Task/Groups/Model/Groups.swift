//
//  Group.swift
//  Pop-A-Task
//
//  Created by Sangam Gurung on 2023-02-14.
//


import Foundation
import FirebaseFirestoreSwift

struct Member: Identifiable {
    let id: String
    let name: String
}
struct Groups: Codable, Identifiable, Hashable {
    @DocumentID var id: String?
    var name: String
    var description: String
    var members: [String]
    var createDate: Date
    var createBy: String
    var groupID: String
//    let isFavorite: Bool
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case members
        case createDate
        case createBy
        case groupID
    }
}
