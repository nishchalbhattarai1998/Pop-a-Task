
import Foundation
import FirebaseFirestoreSwift

struct Task: Identifiable, Codable, Hashable {
    @DocumentID var id: String?
    var name: String
    var description: String?
    var category: String?
    var status: String?
    var priority: String?
    var assignee: String?
    var group: String?
    var groupID: String?
    var deadline: Date?
    var createdBy: String?
    var createdAt: Date?
    var taskID: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case category
        case status
        case priority
        case assignee
        case group
        case groupID
        case deadline
        case createdBy
        case createdAt
        case taskID
    }

    init(id: String?, name: String, description: String?, category: String?, status: String?, priority: String?, assignee: String?, group: String?, groupID: String?, deadline: Date?, createdBy: String?, createdAt: Date?, taskID: String?) {
        self.id = id
        self.name = name
        self.description = description
        self.category = category
        self.status = status
        self.priority = priority
        self.assignee = assignee
        self.group = group
        self.groupID = groupID
        self.deadline = deadline
        self.createdBy = createdBy
        self.createdAt = createdAt
        self.taskID = taskID
    }

    init() {
        self.id = ""
        self.name = ""
        self.description = ""
        self.category = ""
        self.status = ""
        self.priority = ""
        self.assignee = ""
        self.group = ""
        self.groupID = ""
        self.deadline = Date()
        self.createdBy = ""
        self.createdAt = Date()
        self.taskID = ""
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(description)
        hasher.combine(category)
        hasher.combine(status)
        hasher.combine(priority)
        hasher.combine(assignee)
        hasher.combine(group)
        hasher.combine(groupID)
        hasher.combine(deadline)
        hasher.combine(createdBy)
        hasher.combine(createdAt)
        hasher.combine(taskID)
    }
}
