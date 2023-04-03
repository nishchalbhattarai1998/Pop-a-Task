//
//  TaskDetail.swift
//  Pop-A-Task
//
//  Created by manpreet Kaur on 2023-03-20.
//

import Foundation
import SwiftUI

struct TaskDetail: View {
    @ObservedObject var userData = UserData()
    let task: Task
    @State private var comment: String = ""
    @ObservedObject var commentStore: CommentStore

    init(task: Task) {
        self.task = task
        self.commentStore = CommentStore(taskID: task.id ?? "")
    }
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    var body: some View {
        List {
            Section(header: Text("Task Detail")) {
                VStack(alignment: .leading) {
                    Text("Name: \(task.name)")
                        .font(.subheadline)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                VStack(alignment: .leading) {
                    Text("Description: \(task.description ?? "")")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
            }
            
        }
        
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(task.name)
    }
    
}


struct TaskDetail_Preview: PreviewProvider {
    static var previews: some View {
        TaskDetail(task: Task(id: "1", name: "Test Task",
                              description: "My Task Description",
                              category: "Test Category",
                              status: "Test Status",
                              priority: "Test Priority",
                              assignee: "Test assignee",
                              group: "Test Group",
                              groupID: "1",
                              deadline: Date(),
                              createdBy: "Charles Roy",
                              createdAt: Date(),
                              taskID: "1"))
    }
}
