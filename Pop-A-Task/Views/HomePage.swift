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
            ScrollView{
                VStack{
                    VStack{
                        Text("You have")
                            .padding(.top)
                        HStack{
                            ProgressCircleView2(progress: viewModel.filteredData.count, color: hexToColor(hex: "#60C689"), title: "Groups")
                            
                            ProgressCircleView2(progress: taskViewModel.filteredData.count, color: hexToColor(hex: "#60C689"), title: "Tasks")
                            
                        }

                    }
                    .padding(.horizontal, 110)
                    //                    .padding(10)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(20)
                    //                    .padding(20)
                    
                    
                    VStack {
                        Text("Task Priority")
                            .padding(.top)
                        HStack {
                            if taskViewModel.filteredData.count > 0 {
                                ProgressCircleView1(progress: taskViewModel.highPriorityCount, total: taskViewModel.filteredData.count, color: hexToColor(hex: "#C21858"), title: "High")
                                    .onAppear {
                                        withAnimation(Animation.linear(duration: 100)) {}
                                    }
                                
                                ProgressCircleView1(progress: taskViewModel.mediumPriorityCount, total: taskViewModel.filteredData.count, color: hexToColor(hex: "#be590c"), title: "Mid")
                                    .onAppear {
                                        withAnimation(Animation.linear(duration: 100)) {}
                                    }
                                
                                ProgressCircleView1(progress: taskViewModel.lowPriorityCount, total: taskViewModel.filteredData.count, color: hexToColor(hex: "#570CBE"), title: "Low")
                                    .onAppear {
                                        withAnimation(Animation.linear(duration: 100)) {}
                                    }
                            } else {
                                Text("No tasks found.")
                            }
                        }
                    }
                    
                    .padding(.horizontal, 65)
                    .padding(.top, 0)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(20)
                    
                    VStack {
                        Text("Task Status")
                            .padding(.top)
                        HStack {
                            if taskViewModel.filteredData.count > 0 {
                                ProgressCircleView1(progress: taskViewModel.todoCount, total: taskViewModel.filteredData.count, color: hexToColor(hex: "#C21858"), title: "To-Do")
                                    .onAppear {
                                        withAnimation(Animation.linear(duration: 100)) {}
                                    }
                                
                                ProgressCircleView1(progress: taskViewModel.inProgressCount, total: taskViewModel.filteredData.count, color: hexToColor(hex: "#be590c"), title: "Doing")
                                    .onAppear {
                                        withAnimation(Animation.linear(duration: 100)) {}
                                    }
                                
                                ProgressCircleView1(progress: taskViewModel.doneCount, total: taskViewModel.filteredData.count, color: hexToColor(hex: "#570CBE"), title: "Done")
                                    .onAppear {
                                        withAnimation(Animation.linear(duration: 100)) {}
                                    }
                            } else {
                                Text("No tasks found.")
                            }
                        }
                    }
                    
                    .padding(.horizontal, 65)
                    .padding(.top, 0)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(20)
                    
                    VStack {
                        Text("Deadlines")
                            .padding(.top, 0)
                        BarChartView(data: deadlineData, maxHeight: CGFloat(taskViewModel.filteredData.count * 10), colors: deadlineColors, labels: deadlineLabels, showPercentage: true)
                    }
                    .padding(.horizontal, 25)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(20)
                    
                }
                .navigationTitle("Pop A Task")
                
            }
            .padding(.bottom)
        }
    }
    
    private var deadlineData: [Double] {
        let totalCount = Double(taskViewModel.overdueCount + taskViewModel.dueSoonCount + taskViewModel.dueThisWeekCount + taskViewModel.dueLaterCount)

        if totalCount == 0 {
            return [0, 0, 0, 0]
        } else {
            return [
                Double(taskViewModel.overdueCount) / totalCount * 100,
                Double(taskViewModel.dueSoonCount) / totalCount * 100,
                Double(taskViewModel.dueThisWeekCount) / totalCount * 100,
                Double(taskViewModel.dueLaterCount) / totalCount * 100
            ]
        }
    }

    
    private var deadlineColors: [Color] {
        return [
            .purple,
            .red,
            .orange,
            .green
        ]
    }
    
    private var deadlineLabels: [String] {
        return [
            "Overdue",
            "Due Soon",
            "This Week",
            "Due Later"
        ]
    }

    
    func hexToColor(hex: String, opacity: Double = 1.0) -> Color {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        
        if (cString.count) != 6 {
            return Color.gray
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        let r = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let g = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let b = Double(rgbValue & 0x0000FF) / 255.0
        
        return Color(red: r, green: g, blue: b, opacity: opacity)
    }
    
}


struct HomeView_Previews: PreviewProvider{
    static var previews: some View{
        HomeView()
    }
}
