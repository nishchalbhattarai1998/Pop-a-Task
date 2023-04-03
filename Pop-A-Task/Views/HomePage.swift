import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel = GroupViewModel()
    @ObservedObject var taskViewModel = TaskViewModel()
    @State private var tasks = [Task]()
//    @State var group: Double = 0.2
//    @State var tasks: Double = 0.2
    @State var inProgress: Double = 0.2
    @State var complete: Double = 0.2
    @State var overdue: Double = 0.2
    
    var body: some View {
        NavigationView {
            VStack{
                HStack{
                    VStack{
                        ProgressCircleView1(progress: viewModel.filteredData.count, color: .orange, title: "Groups")
                    }
                    .onAppear {
                        withAnimation(Animation.linear(duration: 100)) {
                        }
                    }
                
                .padding(.top, 5)
                
                VStack{
                    ProgressCircleView1(progress: taskViewModel.filteredData.count, color: .orange, title: "Tasks")
                }
                .onAppear {
                    withAnimation(Animation.linear(duration: 100)) {
                    }
                }
                .padding(.top, 20)
                }
            }
            .padding(.bottom, 500)
        }
    }
}

struct HomeView_Previews: PreviewProvider{
    static var previews: some View{
        HomeView()
    }
}
