//
//  RaskSetting.swift
//  Pop-A-Task
//
//  Created by Charles Roy on 2023-03-19.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift
import Firebase
import FirebaseFirestore


struct Category: Codable, Identifiable, Hashable {
    @DocumentID var id: String?
    var name: String
    var tasks: [String]?
    var createDate: Date?
    var createBy: String?
    var categoryID: String?

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    init(id: String? = nil, name: String, tasks: [String] = [], createDate: Date = Date(), createBy: String, categoryID: String) {
        self.id = id
        self.name = name
        self.tasks = tasks
        self.createDate = createDate
        self.createBy = createBy
        self.categoryID = categoryID
    }

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case tasks
        case createDate
        case createBy
        case categoryID
    }
}

struct Priority: Codable, Identifiable, Hashable {
    @DocumentID var id: String?
    var name: String
    var tasks: [String]?
    var createDate: Date?
    var createBy: String?
    var priorityID: String?

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    init(id: String? = nil, name: String, tasks: [String] = [], createDate: Date = Date(), createBy: String, priorityID: String) {
        self.id = id
        self.name = name
        self.tasks = tasks
        self.createDate = createDate
        self.createBy = createBy
        self.priorityID = priorityID
    }

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case tasks
        case createDate
        case createBy
        case priorityID
    }
}

struct Status: Codable, Identifiable, Hashable {
    @DocumentID var id: String?
    var name: String
    var tasks: [String]?
    var createDate: Date?
    var createBy: String?
    var statusID: String?

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    init(id: String? = nil, name: String, tasks: [String] = [], createDate: Date = Date(), createBy: String, statusID: String) {
        self.id = id
        self.name = name
        self.tasks = tasks
        self.createDate = createDate
        self.createBy = createBy
        self.statusID = statusID
    }

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case tasks
        case createDate
        case createBy
        case statusID
    }
}
