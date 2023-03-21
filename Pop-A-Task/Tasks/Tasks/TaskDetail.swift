//
//  TaskDetail.swift
//  Pop-A-Task
//
//  Created by manpreet Kaur on 2023-03-20.
//

import Foundation
import SwiftUI

struct TaskDetail: View {
    let task: Task
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
            
            Section(header: Text("Setting")) {
                VStack(alignment: .leading) {
                    
                    Text("Category: \(task.category ?? "")")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
            
                VStack(alignment: .leading) {
                    Text("Status: \(task.status ?? "")")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
            
                VStack(alignment: .leading) {
                    Text("Priority: \(task.priority ?? "")")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
            }
            
            Section(header: Text("Deadline")) {
                VStack(alignment: .leading) {
                    Text(dateFormatter.string(from: task.deadline ?? Date()))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
            }
            
            Section(header: Text("Group")) {
                VStack(alignment: .leading) {
                    Text(task.group ?? "")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
            }
            
            Section(header: Text("Assigned to")) {
                VStack(alignment: .leading) {
                    Text(task.assignee ?? "")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
            }

            
            Section(header: Text("Created")) {
                VStack(alignment: .leading) {
                    Text("By: \(task.createdBy ?? "")")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                }
                .padding()

                VStack(alignment: .leading) {
                    Text("At: \(dateFormatter.string(from: task.createdAt ?? Date()))")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                }
                .padding()
            }
            
            .frame(maxWidth: .infinity, alignment: .leading)
            
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
                              deadline: Date(),
                              createdBy: "Charles Roy",
                              createdAt: Date()))
    }
}
