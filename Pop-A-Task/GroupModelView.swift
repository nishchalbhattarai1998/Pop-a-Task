
//
//  GroupModalView.swift
//  Pop-A-Task
//
//  Created by nishchal bhattarai on 2023-02-17.
//

import Foundation
import SwiftUI
import FirebaseFirestore

struct ModalView: View {
    @Binding var isShowingModal: Bool
    @State var groupName = ""
    @State var description = ""
    @State  var selectedOption: Int
    @ObservedObject var userData = UserData()
    let options = ["Option 1", "Option 2", "Option 3"]
    let db = Firestore.firestore()
    var body: some View {
        VStack {
            HStack {
                //                Text("This is Group modal view")
                //                    .font(.largeTitle)
                //                    .padding()
                Text("Add Task").font(.headline)
                    .font(.headline)
                    .padding()
                Spacer()
                Button(action: {
                    isShowingModal = false
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundColor(.gray)
                        .padding()
                }
            }
            Divider()
            
            
            TextField("Name of the group", text: $groupName)
                .padding()
                .background(Color(hue: 0.345, saturation: 0.095, brightness: 0.952))
                .cornerRadius(15.0)
            //                        Spacer()
            Divider()
            TextField("Description of the group", text: $description).frame( width: 400, height: 50)
                .padding()
                .background(Color(hue: 0.345, saturation: 0.095, brightness: 0.952))
                .cornerRadius(15.0)
            Divider()
            //            VStack{
            Picker("Select an option", selection: $selectedOption) {
                ForEach(0 ..< options.count) {i in
                    Text(options[i]).onTapGesture {
                        selectedOption = i
                    }
                }
            }.pickerStyle(MenuPickerStyle())
            
            Text("You selected: \(options[selectedOption])")
            HStack{
                Button("Dismiss") {
                    isShowingModal = false
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
                
                Button("Create") {
                    addGroup()
                    isShowingModal = false
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
            }
            //            }
            //            .padding()
            //            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
            .cornerRadius(20)
            //            .shadow(radius: 20)
        }
    }
    
    func addGroup() {
        let group = Groups(name: groupName, description: description, members: [], createDate: Date(), createBy: userData.userName!)
        do {
            let _ = try db.collection("groups").addDocument(from: group)
            print("Group added successfully to Firestore")
        } catch let error {
            print("Error adding group to Firestore: \(error.localizedDescription)")
        }
    }
}
    struct ModalView_Previews: PreviewProvider {
        static var previews: some View {
            ModalView(isShowingModal: .constant(true), selectedOption: 0)
        }
    }

