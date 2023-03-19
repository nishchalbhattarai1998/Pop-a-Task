//
//  RaskSetting.swift
//  Pop-A-Task
//
//  Created by Charles Roy on 2023-03-19.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift

protocol TaskSettingItem: Codable, Identifiable {
    var id: String? { get }
    var taskId: String { get }
    var name: String { get }
}

struct Category: TaskSettingItem {
    @DocumentID var id: String?
    var taskId: String
    var name: String
}

struct Status: TaskSettingItem {
    @DocumentID var id: String?
    var taskId: String
    var name: String
}

struct Priority: TaskSettingItem {
    @DocumentID var id: String?
    var taskId: String
    var name: String
}

struct TaskSettings: Codable {
    var categories: [Category]
    var status: [Status]
    var priority: [Priority]
}
