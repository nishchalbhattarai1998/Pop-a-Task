//
//  TaskSettingModel.swift
//  Pop-A-Task
//
//  Created by Charles Roy on 2023-03-19.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import Combine

class TaskSettingsModel: ObservableObject {
    @Published var taskSettings: TaskSettings = TaskSettings(categories: [], status: [], priority: [])

    private let db = Firestore.firestore()
    private let settingsPath = "task_settings"
    private var cancellables: Set<AnyCancellable> = []

    init() {
        fetchTaskSettings()
    }

    func fetchTaskSettings() {
        db.collection(settingsPath).document("settings").addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }

            guard let data = document.data() else {
                print("Document data was empty.")
                return
            }

            do {
                self.taskSettings = try Firestore.Decoder().decode(TaskSettings.self, from: data)
            } catch let error {
                print("Error decoding TaskSettings: \(error)")
            }
        }
    }

    func updateTaskSettings(taskSettings: TaskSettings, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            let documentData = try Firestore.Encoder().encode(taskSettings)
            db.collection(settingsPath).document("settings").setData(documentData) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        } catch let error {
            completion(.failure(error))
        }
    }

    func addItem<T: TaskSettingItem>(item: T, itemType: String, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            let documentData = try Firestore.Encoder().encode(item)
            db.collection(itemType).addDocument(data: documentData) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        } catch let error {
            completion(.failure(error))
        }
    }

    func deleteItem(item: any TaskSettingItem, itemType: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let itemId = item.id else {
            completion(.failure(NSError(domain: "TaskSettingsModel", code: -1, userInfo: [NSLocalizedDescriptionKey: "Item id is missing"])))
            return
        }

        db.collection(itemType).document(itemId).delete { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }

    func moveItem<T: TaskSettingItem>(item: T, itemType: String, newIndex: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        // You can customize this function based on the specific requirements for moving items within the Firestore.
        // For example, you may need to reorder items based on a specific field or set a new order value.
    }
}
