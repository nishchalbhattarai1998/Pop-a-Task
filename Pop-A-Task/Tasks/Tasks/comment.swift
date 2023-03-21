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

struct Comment: Identifiable, Decodable {
    let id: UUID
    let comment: String
    let commentedBy: String
    let taskID: String
    let commented: Date
    
    init(comment: String, commentedBy: String, taskID: String) {
        self.id = UUID()
        self.comment = comment
        self.commentedBy = commentedBy
        self.taskID = taskID
        self.commented = Date()
    }
}
