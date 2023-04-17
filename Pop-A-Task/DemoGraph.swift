//
//  demo2.swift
//  Pop-A-Task
//
//  Created by nishchal bhattarai on 2023-03-19.
//

import Foundation
import SwiftUI

struct ProgressCircleView1: View {
    var progress: Int
    var total: Int
    var color: Color
    var title: String
    
    var body: some View {
        let progressPercent = min(progress * 100 / total, 100)
        
        ZStack {
            Circle()
                .stroke(lineWidth: 16)
                .opacity(0.3)
                .foregroundColor(Color.gray.opacity(0.5))
            
            Circle()
                .trim(from: 0, to: CGFloat(Double(progressPercent)) / 100)
                .stroke(style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                .foregroundColor(color)
                .rotationEffect(Angle(degrees: -90))
                .animation(.linear)
                        
            VStack {
                Text("\(progressPercent)%")
                    .font(.system(size: 12))
                    .foregroundColor(color)
                    .bold()
            }
            VStack {
                Text(title)
                    .font(.system(size: 12))
                    .padding(.top, 120)
                    .padding(.bottom, 20)
            }
        }
        .frame(width: 50, height: 80)
        .padding()
        .cornerRadius(20)
        .padding(.bottom)
    }
}

struct BarChartView_Previews: PreviewProvider {
    static var previews: some View {
        BarChartView(data: [20, 60, 80, 100, 30], maxHeight: 200, colors: [.red, .yellow, .green, .blue, .green], labels: ["Label 1", "Label 2", "Label 3", "Label 4", "Laqbel 5"], showPercentage: true)
    }
}

//struct ProgressCircleView2_Previews: PreviewProvider {
//    static var previews: some View {
//        VStack {
//            ProgressCircleView2(progress: 75, color: .blue, title: "Completed")
//            ProgressCircleView2(progress: 25, color: .red, title: "Incomplete")
//        }
//    }
//}


struct ProgressCircleView2: View {
    var progress: Int
    var color: Color
    var title: String
    
    var body: some View {
        let progressPercent = min(progress, 100)
        
        ZStack {
            Circle()
                .stroke(lineWidth: 8)
                .opacity(0.3)
                .foregroundColor(Color.gray.opacity(0.5))
                .padding(.top, -20)
            
            Circle()
//                .trim(from: 0, to: CGFloat(Double(progressPercent)))
//                .stroke(style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .round))
                .foregroundColor(color)
                .rotationEffect(Angle(degrees: -90))
                .animation(.linear)
                .padding(.top, -20)
                        
            VStack {
                Text("\(progressPercent)")
                    .font(.system(size: 25))
                    .foregroundColor(Color(UIColor.systemBackground))
                    .bold()
                    .padding(.top, -20)
            }
            VStack {
                Text(title)
                    .font(.system(size: 12))
                    .padding(.top, 90)
                    .padding(.bottom, 20)
                    
            }
        }
        .frame(width: 50, height: 80)
        .padding(15)
    }
}



import SwiftUI

struct BarChartView: View {
    let data: [Double]
    let maxHeight: CGFloat
    let colors: [Color]
    let labels: [String]
    let showPercentage: Bool
    
    init(data: [Double], maxHeight: CGFloat, colors: [Color], labels: [String], showPercentage: Bool = false) {
        self.data = data
        self.maxHeight = maxHeight
        self.colors = colors
        self.labels = labels
        self.showPercentage = showPercentage
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 50) {
                ForEach(data.indices) { index in
                    BarView(value: data[index], maxHeight: maxHeight, color: colors[index], showPercentage: showPercentage)
                }
            }
            HStack(spacing: 25) {
                ForEach(labels.indices) { index in
                    Text(labels[index])
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

struct BarView: View {
    let value: Double
    let maxHeight: CGFloat
    let color: Color
    let showPercentage: Bool
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                Capsule()
                    .frame(width: 5, height: maxHeight)
                    .foregroundColor(Color.gray.opacity(0.1))
                
                Capsule()
                    .frame(width: 10, height: CGFloat(value / 100 * Double(maxHeight)))
                    .foregroundColor(color)
                    .shadow(radius: 4)
            }
            if showPercentage {
                Text(String(format: "%.0f%%", value))
            } else {
                Text(String(format: "%.0f", value))
            }
        }
    }
}
