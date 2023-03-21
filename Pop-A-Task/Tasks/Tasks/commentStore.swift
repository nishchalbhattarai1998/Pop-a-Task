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
    let taskID: String
    let db = Firestore.firestore()

    init(taskID: String) {
        self.taskID = taskID
        loadComments()
    }

    private func loadComments() {
        db.collection("comments")
            .whereField("taskID", isEqualTo: taskID)
            .order(by: "createdAt", descending: false)
            .addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("No comments found")
                    return
                }

                self.comments = documents.compactMap { (queryDocumentSnapshot) -> Comment? in
                    return try? queryDocumentSnapshot.data(as: Comment.self)
                }
            }
    }

    func saveComment(_ comment: Comment) {
        db.collection("comments").addDocument(data: [
            "comment": comment.comment,
            "commentedBy": comment.commentedBy,
            "taskID": comment.taskID,
            "createdAt": Date()
        ]) { err in
            if let err = err {
                print("Error adding comment: \(err)")
            } else {
                print("Comment successfully added")
            }
        }
    }

    // Add a new comment to the store
    func addComment(comment: String, commentedBy: String) {
        let newComment = Comment(comment: comment, commentedBy: commentedBy, taskID: taskID)
        comments.append(newComment)

        // Save the new comment to the database
        saveComment(newComment)
    }
}
