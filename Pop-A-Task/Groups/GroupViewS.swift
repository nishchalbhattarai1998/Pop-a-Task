import SwiftUI

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
                    Button("Add", action: makeContact)
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
    
   
    func makeContact() {
        withAnimation {
            guard let randomContact = viewModel.store.groups.randomElement() else {
                return
            }
            viewModel.makeContact(contact: randomContact)
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

