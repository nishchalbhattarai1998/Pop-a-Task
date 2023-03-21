//
//  commentStore.swift
//  Pop-A-Task
//
//  Created by Neetay layal on 2023-03-20.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore

class CommentStore: ObservableObject {
    @Published var comments: [Comment] = []
    var taskID: String
    var listener: ListenerRegistration?
    
    init(taskID: String) {
        self.taskID = taskID
        fetchComments()
    }
    
    deinit {
        unsubscribe()
    }
    
    private func fetchComments() {
        let commentsRef = Firestore.firestore().collection("tasks/\(taskID)/comments")
        listener = commentsRef.addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("Error getting comments: \(error.localizedDescription)")
                return
            }
            
            self.comments = querySnapshot?.documents.compactMap { document in
                try? document.data(as: Comment.self)
            } ?? []
        }
    }
    
    private func unsubscribe() {
        listener?.remove()
    }
    
    func addComment(comment: String, commentedBy: String, taskID: String) {
        let commentsRef = Firestore.firestore().collection("tasks/\(taskID)/comments")
        let newComment = Comment(comment: comment, commentedBy: commentedBy, commented: Date())
        
        do {
            _ = try commentsRef.addDocument(from: newComment)
        } catch {
            print("Error adding comment: \(error.localizedDescription)")
        }
    }


}
