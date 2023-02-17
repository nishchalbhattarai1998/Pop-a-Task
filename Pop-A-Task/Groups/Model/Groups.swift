//
//  Group.swift
//  Pop-A-Task
//
//  Created by Sangam Gurung on 2023-02-14.
//

//import Foundation
//
//struct Groups: Identifiable {
//    let id = UUID()
//    let groupName: String
//    let isFavorite: Bool
//    }

import Foundation
import FirebaseFirestoreSwift

struct Groups: Codable, Identifiable {
    @DocumentID var id = UUID().uuidString
    var name: String
    var description: String
    var members: [String]
    var createDate: Date
    var createBy: String
//    let isFavorite: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case members
        case createDate
        case createBy
    }
}
