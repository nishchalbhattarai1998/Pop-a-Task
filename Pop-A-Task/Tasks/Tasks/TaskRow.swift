//
//  TaskRow.swift
//  Pop-A-Task
//
//  Created by manpreet Kaur on 2023-03-20.
//

import Foundation
import SwiftUI

struct TaskRow: View {
    let task: Task
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()

    var body: some View {
        NavigationLink(destination: TaskDetail(task: task)) {
            VStack {
                Text(task.name)
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                    .padding(.leading)
                    .padding(.bottom, 0.1)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text(task.description ?? "")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                    .padding(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Category: \(task.category ?? "")")
                    .font(.caption2)
                    .fontWeight(.light)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                    .padding(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Assigned To: \(task.assignee ?? "")")
                    .font(.caption2)
                    .fontWeight(.light)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                    .padding(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Deadline: \(dateFormatter.string(from: task.deadline ?? Date()))")
                    .font(.caption2)
                    .fontWeight(.light)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                    .padding(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)

                HStack {
                    Text("Created By: \(task.createdBy ?? "")")
                        .font(.caption)
                        .fontWeight(.light)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                        .padding(.leading)
                    Spacer()
                    Text("Created At: \(dateFormatter.string(from: task.createdAt ?? Date()))")
                        .font(.caption)
                        .fontWeight(.light)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                        .padding(.leading)
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .leading) 
            }

        }
    }
}


struct TaskRow_Previews: PreviewProvider {
        static var previews: some View {
            TaskRow(task: Task(id: "1", name: "Test Task",
                               description: "My Task Description",
                               category: "Test Category",
                               status: "Test Status",
                               priority: "Test Priority",
                               assignee: "Test assignee",
                               group: "Test Group",
                               deadline: Date(),
                              createdBy: "Charles Roy",
                               createdAt: Date()))
        }
    }
