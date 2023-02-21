
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift
struct MemberModalView: View {
    @Binding var isShowingModal: Bool
    @State var searchTerm = ""
    @State var groupName = ""
    @State var description = ""
    @EnvironmentObject var groupViewModel: GroupViewModel
//    @ObservedObject var groupViewModel: GroupViewModel
    var id: String
    let db = Firestore.firestore()

    var body: some View {
        NavigationView {
            List {
                ForEach(self.groupViewModel.filteredUsers, id: \.id) { user in
                    Button(user.name) {
                        groupViewModel.addMembersToGroup(id: id, members: [user.name])
                        isShowingModal = false
                    }
                }

                HStack{
                    Spacer()
                    if !groupViewModel.filteredUsers.isEmpty {
                        Section {
                            Text("\(groupViewModel.filteredUsers.count) user(s) found")
                                .foregroundColor(.gray)
                        }
                    } else {
                        Section {
                            Text("No users found")
                                .foregroundColor(.gray)
                        }
                    }
                    Spacer()
                }
            }
            .navigationTitle("Add Members")
            .searchable(text: $searchTerm,
                        placement: .navigationBarDrawer(displayMode: .automatic),
                        prompt: "Search for users")
            .onChange(of: searchTerm) { newValue in
                groupViewModel.filterSearchResultsU(searchTerm: searchTerm)
            }
            .toolbar {
                HStack {
                    EditButton()
                    Button("Cancel") {
                        isShowingModal = false
                    }
                }
            }
            .listRowBackground(Color(UIColor.systemBackground))
            .listStyle(GroupedListStyle())

            if !groupViewModel.filteredUsers.isEmpty {
                Section {
                    Text("\(groupViewModel.filteredUsers.count) search result(s)")
                }
            }
        }
        .animation(.default, value: searchTerm)
    }
}

struct MemberModalView_Previews: PreviewProvider {
    static var previews: some View {
        MemberModalView(isShowingModal: .constant(true), id: "")
            .environmentObject(GroupViewModel())
    }
}
