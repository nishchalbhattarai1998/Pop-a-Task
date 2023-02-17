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

struct GroupView: View {
    @ObservedObject var viewModel: GroupViewModel
    @State private var isShowingModal = false
    let db = Firestore.firestore()
    
    var body: some View {
        NavigationView {
            List {
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
            .animation(.easeInOut, value: viewModel.searchTerm)

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

/// Contact list view
//struct GroupView: View {
//    @ObservedObject var viewModel: GroupViewModel
//    @State private var isShowingModal = false
//    let db = Firestore.firestore()
//
//    var body: some View {
//
//        NavigationView {
//
//            List {
//                ForEach(viewModel.listData) { group in
//                    GroupRow(group: group)
//                }
//                .onMove(perform: moveGroup)
//                .onDelete(perform: deletGroup)
//
//                HStack {
//                    Spacer()
//                    Text(viewModel.displayCount)
//                        .foregroundColor(.gray)
//
//                    Spacer()
//                }
//            }
//            .navigationTitle(viewModel.navTitle)
//            // To Add search capability
//            .searchable(text: $viewModel.searchTerm,
//                        placement: .navigationBarDrawer(displayMode: .automatic),
//                        prompt: "Search for groups")
//            .onChange(of: viewModel.searchTerm, perform: { newValue in viewModel.filterSearchResults()
//            }
//            )
//            .animation(.default, value: viewModel.searchTerm)
//            // Toolbar: Add and Edit
//            .toolbar {
//                HStack {
//                    Button("Add"){
//                        isShowingModal = true
//
//                    }.sheet(isPresented: $isShowingModal) {
//                        ModalView(isShowingModal: $isShowingModal)
//                            .cornerRadius(20)
////                            .padding(50)
////                            .shadow(radius: 20)
////                            .background(Color.gray)
//                    }
//                        Spacer()
//                        EditButton()
//                        Button("Reset", action: resetData)
//
//                }
//            }
//        }}
//
//    func resetData() {
//        viewModel.resetData()
//    }
//
////
////    func addGroups() {
////        withAnimation {
////            guard let randomContact = viewModel.store.groups.randomElement() else {
////                return
////            }
////            viewModel.addGroup(contact: randomContact)
////        }
////    }
//
//
//
//    func moveGroup(from: IndexSet, to: Int) {
//        withAnimation {
//            viewModel.moveGroup(from: from, to: to)
//        }
//    }
//
//
//    func deletGroup(offsets: IndexSet) {
//        withAnimation {
//            viewModel.deleteGroup(offsets: offsets)
//        }
//    }
//}

struct GroupView_Previews: PreviewProvider {
    static var previews: some View {
        GroupView(viewModel: GroupViewModel())
    }
}

