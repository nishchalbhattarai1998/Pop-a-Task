//
//  TaskRow.swift
//  Pop-A-Task
//
//  Created by manpreet Kaur on 2023-03-20.
//

import Foundation
import SwiftUI

struct TaskRow: View {
    @ObservedObject var  taskViewModel = TaskViewModel()
    @ObservedObject var  categoryViewModel = CategoryViewModel()
    @ObservedObject var  statusViewModel = StatusViewModel()
    @ObservedObject var priorityViewModel = PriorityViewModel()
    @ObservedObject var groupViewModel = GroupViewModel()
    @ObservedObject var userViewModel = UserViewModel()
    let task: Task
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    var body: some View {
        NavigationLink(destination: TaskDetail(task: task,
                                               taskViewModel: taskViewModel,
                                               categoryViewModel: categoryViewModel,
                                               statusViewModel: statusViewModel,
                                               priorityViewModel: priorityViewModel,
                                               groupViewModel: groupViewModel,
                                               userViewModel: userViewModel)) {
            VStack {
                HStack {
                   
                    Text(task.name)
                        .font(.headline)
                        .multilineTextAlignment(.leading)
                        .padding(.leading)
                    Spacer()
                    deadlineBadge(for: task.deadline!)
                    
                }
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
//                        .padding(.leading)
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
               
            }
//            .padding(.vertical)
//            .background(Color(UIColor.systemBackground))
//            .cornerRadius(10)
//            .shadow(color: .gray, radius: 1, x: 0, y: 1)
        }
    }
    
    private func deadlineBadge(for date: Date) -> some View {
        let now = Date()
        let daysUntilDeadline = Calendar.current.dateComponents([.day], from: now, to: date).day ?? 0
        
        var badgeColor: Color
        var badgeText: String
        
        switch daysUntilDeadline {
        case ..<0:
            badgeColor = .purple
            badgeText = "Overdue"
        case 0...2:
            badgeColor = .red
            badgeText = "Due Soon"
        case 3...7:
            badgeColor = .orange
            badgeText = "Due This Week"
        default:
            badgeColor = .green
            badgeText = "Due Later"
        }
        
        return Text(badgeText)
            .font(.caption2)
            .foregroundColor(.white)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(badgeColor)
            .cornerRadius(10)
            .padding(.trailing)
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
                               groupID: "1",
                               deadline: Date(),
                              createdBy: "Charles Roy",
                               createdAt: Date(),
                               taskID:"1"))
        }
    }
