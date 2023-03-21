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
    let id: UUID
    let comment: String
    let commentedBy: String
    let commented: Date

    enum CodingKeys: String, CodingKey {
        case id
        case comment
        case commentedBy
        case commented
    }

    init(id: UUID = UUID(), comment: String, commentedBy: String, commented: Date) {
        self.id = id
        self.comment = comment
        self.commentedBy = commentedBy
        self.commented = commented
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.comment = try container.decode(String.self, forKey: .comment)
        self.commentedBy = try container.decode(String.self, forKey: .commentedBy)
        let timestamp = try container.decode(Timestamp.self, forKey: .commented)
        self.commented = timestamp.dateValue()
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(comment, forKey: .comment)
        try container.encode(commentedBy, forKey: .commentedBy)
        try container.encode(Timestamp(date: commented), forKey: .commented)
    }
}
