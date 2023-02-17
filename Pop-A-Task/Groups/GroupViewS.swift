import SwiftUI
import FirebaseFirestore
struct GroupViews: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var isLoggedIn: Bool

        var body: some View {
            Group {
                if isLoggedIn {
                    GroupView(viewModel: GroupViewModel())
                        .onAppear {
                            print("isLoggedIn if state group: \(self.isLoggedIn)")
                        }
                } else {
                    LoginView(isLoggedIn: $isLoggedIn)
                        .onAppear {
                            print("isLoggedIn else state group: \(self.isLoggedIn)")
                        }
                }
            }
        }
}
/// Contact list view
struct GroupView: View {
    @ObservedObject var viewModel: GroupViewModel
    let db = Firestore.firestore()
    var body: some View {
        
        NavigationView {
            
            List {
                ForEach(viewModel.listData) { group in
                    
                    GroupRow(group: group)
                }
                
                .onMove(perform: moveContacts)
                .onDelete(perform: deleteContacts)
                
                HStack {
                    Spacer()
                    Text(viewModel.displayCount)
                        .foregroundColor(.gray)
 
                    Spacer()
                }
            }
            .navigationTitle(viewModel.navTitle)
            // To Add search capability
            .searchable(text: $viewModel.searchTerm,
                        placement: .navigationBarDrawer(displayMode: .automatic),
                        prompt: "Search for groups")
            .onChange(of: viewModel.searchTerm, perform: { newValue in viewModel.filterSearchResults()
            }
            )
            .animation(.default, value: viewModel.searchTerm)
            // Toolbar: Add and Edit
            .toolbar {
                HStack {
                    Button("Add", action: addGroup)
                    Spacer()
                    EditButton()
                    Button("Reset", action: resetData)
                }
            }
        }
    }
    
    func resetData() {
        viewModel.resetData()
    }
    
   
    func addGroup() {
        let group = Groups(name: "New Group", description: "", members: [], createDate: Date())
        do {
            let _ = try db.collection("groups").addDocument(from: group)
            print("Group added successfully to Firestore")
        } catch let error {
            print("Error adding group to Firestore: \(error.localizedDescription)")
        }
    }

    
    
    func moveContacts(from: IndexSet, to: Int) {
        withAnimation {
            viewModel.moveContacts(from: from, to: to)
        }
    }
    
    
    func deleteContacts(offsets: IndexSet) {
        withAnimation {
            viewModel.deleteContact(offsets: offsets)
        }
    }
}

struct ContactsListView_Previews: PreviewProvider {
    static var previews: some View {
        GroupView(viewModel: GroupViewModel())
    }
}

