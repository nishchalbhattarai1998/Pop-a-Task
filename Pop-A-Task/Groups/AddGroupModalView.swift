
//
//  GroupModalView.swift
//  Pop-A-Task
//
//  Created by nishchal bhattarai on 2023-02-17.
// Task Completed

import Foundation
import SwiftUI
import FirebaseFirestore

struct ModalView: View {
    @Binding var isShowingModal: Bool
    @State var groupName = ""
    @State var description = ""
//    @State  var selectedOption: Int
    @ObservedObject var userData = UserData()
//    let options = ["Option 1", "Option 2", "Option 3"]
    let db = Firestore.firestore()
    var body: some View {
        VStack {
            HStack {
                //                Text("This is Group modal view")
                //                    .font(.largeTitle)
                //                    .padding()
                Text("Add Group").font(.largeTitle)
                    
                    .padding(.leading, 35)
                Spacer()
                Button(action: {
                    
                    isShowingModal = false
                }) {
//                    Image(systemName: "xmark.circle.fill")
//                        .font(.title)
//                        .foregroundColor(.gray)
//                        .padding()
                }
            }
            Divider()
            
            
            TextField("Name of the group", text: $groupName)
                .background(Color(hue: 0.345, saturation: 0.095, brightness: 0.952))
                .cornerRadius(15.0)
                .padding()
                .frame(width: 350.0, height: 50.0)
                .background(Color(hue: 0.345, saturation: 0.095, brightness: 0.952))
                .cornerRadius(15.0)
                .padding(10)
            //                        Spacer()
//            Divider()
            TextField(" Description ", text: $description)
                .background(Color(hue: 0.345, saturation: 0.095, brightness: 0.952))
                .cornerRadius(15.0)
                .padding()
                .frame(width: 350.0, height: 50.0)
                .background(Color(hue: 0.345, saturation: 0.095, brightness: 0.952))
                .cornerRadius(15.0)
                .padding(10)
            Divider()
            //            VStack{
//            Picker("Select an option", selection: $selectedOption) {
//                ForEach(0 ..< options.count) {i in
//                    Text(options[i]).onTapGesture {
//                        selectedOption = i
//                    }
//                }
//            }.pickerStyle(MenuPickerStyle())
            
//            Text("You selected: \(options[selectedOption])")
            HStack{
                Button("Dismiss") {
                    isShowingModal = false
                }
                .padding()
                .frame(width: 150, height: 50.0, alignment: .center)
                .background(Color.green)
                .foregroundColor(Color.white)
                .cornerRadius(15.0)
                .padding()
                
                Button("Create") {
                    addGroup()
                    isShowingModal = false
                }
                .padding()
                .frame(width: 150.0, height: 50.0, alignment: .center)
                .background(Color.green)
                .foregroundColor(Color.white)
                .cornerRadius(15.0)
                .padding()
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
        let group = Groups(name: groupName, description: description, members: [userData.userName!], createDate: Date(), createBy: userData.userName!)
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
            ModalView(isShowingModal: .constant(true))
        }
    }

