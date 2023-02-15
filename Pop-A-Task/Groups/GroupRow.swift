//
//  GroupRow.swift
//  Pop-A-Task
//
//  Created by Sangam Gurung on 2023-02-14.
//

import SwiftUI

struct GroupRow: View {
    let group: Groups
    var body: some View {
        NavigationLink( destination: GroupDetail(group: group)) {
            
            HStack {
                Text(group.groupName)
                Spacer()
           
            if group.isFavorite{
                Image(systemName: "star.fill")
                    .font(.headline)
                    .foregroundColor(.yellow)
                
            }
            }
        }
    }
    
    
    struct ContactRow_Previews: PreviewProvider {
        static var previews: some View {
            GroupRow(group: GroupStore.testStore.groups[1])
        }
    }
    
}
