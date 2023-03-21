import Foundation
import FirebaseFirestoreSwift

struct Task: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    var description: String?
    var category: String?
    var status: String?
    var priority: String?
    var assignee: String?
    var group: String?
    var deadline: Date?
    var createdBy: String?
    var createdAt: Date?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case category
        case status
        case priority
        case assignee
        case group
        case deadline
        case createdBy
        case createdAt
    }
    
    init(id: String?, name: String, description: String?, category: String?, status: String?, priority: String?, assignee: String?, group: String?, deadline: Date?, createdBy: String?, createdAt: Date?) {
        self.id = id
        self.name = name
        self.description = description
        self.category = category
        self.status = status
        self.priority = priority
        self.assignee = assignee
        self.group = group
        self.deadline = deadline
        self.createdBy = createdBy
        self.createdAt = createdAt
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
        self.deadline = Date()
        self.createdBy = ""
        self.createdAt = Date()
    }
}
