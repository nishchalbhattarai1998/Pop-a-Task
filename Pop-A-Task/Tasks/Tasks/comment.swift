//
//  Comment.swift
//  Pop-A-Task
//
//  Created by nishchal bhattarai on 2023-03-20.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore

struct Comment: Identifiable, Codable {
    let id: String
    let comment: String
    let commentedBy: String
    let commented: Date
    let isEditable: Bool // Add this property

    enum CodingKeys: String, CodingKey {
        case id
        case comment
        case commentedBy
        case commented
        case isEditable // Add this case
    }

    init(id: String, comment: String, commentedBy: String, commented: Date, isEditable: Bool) {
        self.id = id
        self.comment = comment
        self.commentedBy = commentedBy
        self.commented = commented
        self.isEditable = isEditable // Initialize the property
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.comment = try container.decode(String.self, forKey: .comment)
        self.commentedBy = try container.decode(String.self, forKey: .commentedBy)
        let timestamp = try container.decode(Timestamp.self, forKey: .commented)
        self.commented = timestamp.dateValue()
        self.isEditable = try container.decode(Bool.self, forKey: .isEditable) // Decode the property
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(comment, forKey: .comment)
        try container.encode(commentedBy, forKey: .commentedBy)
        try container.encode(Timestamp(date: commented), forKey: .commented)
        try container.encode(isEditable, forKey: .isEditable) // Encode the property
    }
}
