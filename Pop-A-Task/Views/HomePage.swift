import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel = GroupViewModel()
    @ObservedObject var taskViewModel = TaskViewModel()
    @State var group: Double = 0.2
    @State var tasks: Double = 0.2
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
//                    ProgressCircleView1(progress: Int(taskViewModel.filteredTasks.count), color: .orange, title: "Tasks")
                }
                .onAppear {
                    taskViewModel.fetchTasks { fetchedTasks in
                        self.taskViewModel.filteredTasks = fetchedTasks
                        self.tasks = Double(fetchedTasks.count)
                        
                        // Calculate other progress values here
                        // self.inProgress = ...
                        // self.complete = ...
                        // self.overdue = ...
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
