//
//  GroupRow.swift
//  Pop-A-Task
//
//  Created by Sangam Gurung on 2023-02-14.
//

import SwiftUI

struct GroupRow: View {
    let group: Groups
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        return formatter
    }()

    var body: some View {
        NavigationLink(destination: GroupDetail(group: group)) {
            VStack {
                Text(group.name)
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                    .padding(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text(group.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                    .padding(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)

                HStack {
                    Text("Created By: \(group.createBy)")
                        .font(.caption)
                        .fontWeight(.light)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                        .padding(.leading)

                    Text("Added: \(dateFormatter.string(from: group.createDate))")
                        .font(.caption2)
                        .fontWeight(.light)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                        .padding(.leading, 50)
                }
                .frame(maxWidth: .infinity, alignment: .leading) // align HStack to the left
            }

        }
    }
}


struct GroupRow_Previews: PreviewProvider {
    static var previews: some View {
        if GroupStore.testStore.groups.count > 0 {
            return GroupRow(group: GroupStore.testStore.groups[0])
        } else {
            return GroupRow(group: Groups(name: "Default Group", description: "This is a default group.", members: [], createDate: Date(), createBy: "System"))
        }
    }
}
