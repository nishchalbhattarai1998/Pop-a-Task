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
                if let id = document.documentID as? String,
                   let comment = try? document.data(as: Comment.self) {
                    return Comment(id: id, comment: comment.comment, commentedBy: comment.commentedBy, commented: comment.commented, isEditable: comment.isEditable)
                } else {
                    return nil
                }
            } ?? []
        }
    }

    private func unsubscribe() {
        listener?.remove()
    }

    func addComment(comment: String, commentedBy: String, taskID: String) {
        let commentsRef = Firestore.firestore().collection("tasks/\(taskID)/comments")
        let newComment = Comment(id: UUID().uuidString, comment: comment, commentedBy: commentedBy, commented: Date(), isEditable: true)

        do {
            _ = try commentsRef.document(newComment.id).setData(from: newComment)
        } catch {
            print("Error adding comment: \(error.localizedDescription)")
        }
    }

    func updateComment(id: String, updatedComment: String) {
        let commentRef = Firestore.firestore().document("tasks/\(taskID)/comments/\(id)")

        commentRef.updateData(["comment": updatedComment, "commented": Timestamp(date: Date())]) { error in
            if let error = error {
                print("Error updating comment: \(error.localizedDescription)")
            } else {
                print("Comment updated successfully")
            }
        }
    }

    func deleteComment(id: String) {
        let commentRef = Firestore.firestore().document("tasks/\(taskID)/comments/\(id)")

        commentRef.delete { error in
            if let error = error {
                print("Error deleting comment: \(error.localizedDescription)")
            } else {
                print("Comment deleted successfully")
                self.fetchComments() // <-- Add this line to update the comments array
            }
        }
    }

    func isCommentAuthor(comment: Comment, currentUser: String) -> Bool {
        return comment.commentedBy == currentUser
    }
}
