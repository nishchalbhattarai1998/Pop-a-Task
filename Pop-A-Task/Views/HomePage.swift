import SwiftUI
struct HomeView: View {
    
    @StateObject var viewModel = GroupViewModel()
    @State var group: Double = 0.2
    @State var tasks: Double = 0.2
    @State var inProgress: Double = 0.2
    @State var complete: Double = 0.2
    @State var overdue: Double = 0.2
   
    
    
    var body: some View {
        var percentageGroup = viewModel.filteredData.count
        var percentageTask = tasks
        var percentageInprogress = inProgress/tasks
        var percentageComplete = complete/tasks
        var percentageOverdue = overdue/tasks
        if(percentageOverdue+percentageComplete+percentageOverdue == 1){
            
        }
        NavigationView {
            VStack{
                HStack{
                    VStack{
                        ProgressCircleView1(progress: percentageGroup, color: .orange, title: "Groups")
                    }
                    .onAppear {
                        withAnimation(Animation.linear(duration: 100)) {
//                            self.group = Double(viewModel.filteredData.count)
                        }
                    }
               
                .padding(.top, 5)
                
                VStack{
                    ProgressCircleView1(progress: Int(percentageTask), color: .orange, title: "Tasks")
                }
                .padding(.top, 20)
                }
                HStack{
                    VStack{
                        ProgressCircleView1(progress: Int(percentageInprogress), color: .pink, title: "In progress")
                    }
                    
                    VStack{
                        ProgressCircleView1(progress: Int(percentageComplete), color: .green, title: "Complete")
                    }
                }
                
                HStack{
                    ProgressCircleView1(progress: Int(percentageOverdue), color: .red, title: "Overdue")
                }
                .padding(.top)
            }
            .padding(.bottom, 5)
        }
    }
}

//struct ProgressCircleView: View {
//
//    var progress: Int
//    var color: Color
//    var title: String
//    var percentage: Int
//
//    var body: some View {
//        VStack {
//            ZStack {
//                Circle()
//                    .stroke(lineWidth: 10.0)
//                    .opacity(0.3)
//                    .foregroundColor(color)
//
//                Circle()
//                    .trim(from: 0.0, to: CGFloat(min(Float(progress) / 100.0, 1.0)))
//                    .stroke(style: StrokeStyle(lineWidth: 10.0, lineCap: .round, lineJoin: .round))
//                    .foregroundColor(color)
//                    .rotationEffect(Angle(degrees: 270.0))
//                    .animation(.linear)
//
//                VStack {
//                    Text("\(percentage)%")
//                        .font(.title)
//                        .fontWeight(.bold)
//                    Text(title)
//                        .fontWeight(.medium)
//                        .foregroundColor(.gray)
//                }
//            }
//        }
//        .frame(width: 150, height: 150)
//    }
//}

struct HomeView_Previews: PreviewProvider{
    static var previews: some View{
        HomeView()
    }
}
