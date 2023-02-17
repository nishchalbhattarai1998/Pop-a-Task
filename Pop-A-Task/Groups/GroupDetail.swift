//
//  GroupDetail.swift
//  Pop-A-Task
//
//  Created by Sangam Gurung on 2023-02-14.
//

import Foundation
import SwiftUI

struct GroupDetail: View {
    let group: Groups
    
    var body: some View {
        VStack {
            VStack(alignment: .leading){
                HStack{
                    Text(group.name)
                        .font(.largeTitle)
                    
                }}
//                    Divider()
//                    HStack {
//                        Text("Phone")
//                            .foregroundColor(.black)
//                            .font(.headline)
//                        
//                        Spacer()
//                        
//                        Text(group.phone)
//                            .foregroundColor(.gray)
//                            .font(.headline)
//                    }
//                    .padding(.bottom, 5)
//                    .padding(.leading, 5)
//                    .padding(.trailing, 5)
//                    
//                    Divider()
//                    
//                    HStack {
//                        Text("Email")
//                            .foregroundColor(.black)
//                            .font(.headline)
//                        
//                        Spacer()
//                        
//                        Text(group.email)
//                            .foregroundColor(.gray)
//                            .font(.headline)
//                    }
//                    .padding(.bottom, 5)
//                    .padding(.leading, 5)
//                    .padding(.trailing, 5)
//                    
//                    Divider()
//                    
//                    HStack {
//                        Text("Address")
//                            .foregroundColor(.black)
//                            .font(.headline)
//                        
//                        Spacer()
//                        
//                        Text(group.address)
//                            .foregroundColor(.gray)
//                            .font(.headline)
//                    }
//                    .padding(.bottom, 5)
//                    .padding(.leading, 5)
//                    .padding(.trailing, 5)
//                    
//                    Divider()
                }
            }
        }


struct GroupDetail_Previews: PreviewProvider {
    static var previews: some View {
        GroupDetail(group: GroupStore.testStore.groups[0])
    }
}
