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
                    .font(.system(size: 15))
                    .foregroundColor(color)
                    .bold()
            }
            VStack {
                Text(title)
                    .font(.system(size: 12))
                    .padding(.top, 80)
            }
        }
        .frame(width: 50, height: 120)
        .padding()
        .cornerRadius(20)
    }
}

struct BarChartView_Previews: PreviewProvider {
    static var previews: some View {
        BarChartView(data: [20, 60, 80, 100], maxHeight: 200, colors: [.red, .yellow, .green, .blue], labels: ["Label 1", "Label 2", "Label 3", "Label 4"])
    }
}


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
            
            Circle()
                .trim(from: 0, to: CGFloat(Double(progressPercent)))
                .stroke(style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .round))
                .foregroundColor(color)
                .rotationEffect(Angle(degrees: -90))
                .animation(.linear)
                        
            VStack {
                Text("\(progressPercent)")
                    .font(.system(size: 15))
                    .foregroundColor(color)
                    .bold()
            }
            VStack {
                Text(title)
                    .font(.system(size: 12))
                    .padding(.top, 80)
            }
        }
        .frame(width: 50, height: 120)
        .padding()
//        .background(Color.gray)
        .cornerRadius(20)
    }
}


//Bar Chart
import SwiftUI
struct BarChartView: View {
    let data: [Double]
    let maxHeight: CGFloat
    let colors: [Color]
    let labels: [String]
    
    init(data: [Double], maxHeight: CGFloat, colors: [Color], labels: [String]) {
        self.data = data
        self.maxHeight = maxHeight
        self.colors = colors
        self.labels = labels
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 70) {
                ForEach(data.indices) { index in
                    BarView(value: data[index], maxHeight: maxHeight, color: colors[index])
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
            Text(String(format: "%.0f", value))
        }
    }
}
