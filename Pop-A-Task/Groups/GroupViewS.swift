import SwiftUI
import FirebaseFirestore
import Firebase

//struct GroupViews: View {
//    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
//    @Binding var isLoggedIn: Bool
//
//        var body: some View {
//            Group {
//                if isLoggedIn {
//                    GroupView(viewModel: GroupViewModel())
//                        .onAppear {
//                            print("isLoggedIn if state group: \(self.isLoggedIn)")
//                        }
//                } else {
//                    LoginView(isLoggedIn: $isLoggedIn)
//                        .onAppear {
//                            print("isLoggedIn else state group: \(self.isLoggedIn)")
//                        }
//                }
//            }
//        }
//}

struct GroupView: View {
    @ObservedObject var viewModel: GroupViewModel
    @ObservedObject var userData = UserData()
    @State private var isShowingModal = false
    let db = Firestore.firestore()
//    let group = Groups

    
    var body: some View {
        NavigationView {
            List {
//                let userID = userData.userID
                    ForEach(viewModel.filteredData) { group in
                        GroupRow(group: group)
                    }
                    .onMove(perform: moveGroup)
                    .onDelete(perform: deletGroup)
                    //                .frame(width: 350.0)
                HStack {
                    Spacer()
                    Text(viewModel.displayCount)
                        .foregroundColor(.green)
                    
                    Spacer()
                }
            }
            .id(viewModel.listData) // observe the viewModel's listData property
            .navigationTitle(viewModel.navTitle)
            .backgroundStyle(.green)
            .cornerRadius(15)
            .searchable(text: $viewModel.searchTerm,
                        placement: .navigationBarDrawer(displayMode: .automatic),
                        prompt: "Search for groups")
            .onChange(of: viewModel.searchTerm) { newValue in
                viewModel.filterSearchResults()
            }
            .animation(.default, value: viewModel.searchTerm)

            // Toolbar: Add and Edit
            .toolbar {
                HStack {
                    Button("Add"){
                        isShowingModal = true
                        
                    }.sheet(isPresented: $isShowingModal) {
                        ModalView(isShowingModal: $isShowingModal)
                            .cornerRadius(20)
//                            .padding(50)
//                            .shadow(radius: 20)
//                            .background(Color.gray)
                    }
                        Spacer()
                        EditButton()
//                        Button("Reset", action: resetData)
                    
                }
            }
        }
    }
    
//    func resetData() {
//        viewModel.resetData()
//    }
    
    func moveGroup(from: IndexSet, to: Int) {
        withAnimation {
            viewModel.moveGroup(from: from, to: to)
        }
    }
    
    func deletGroup(offsets: IndexSet) {
        withAnimation {
            viewModel.deleteGroup(at: offsets)
        }
    }

}

struct GroupView_Previews: PreviewProvider {
    static var previews: some View {
        GroupView(viewModel: GroupViewModel())
    }
}
