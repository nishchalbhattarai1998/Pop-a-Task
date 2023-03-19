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
    var color: Color
    var title: String
    
    var body: some View {
        let progressPercent = min(progress, 100)
        
        ZStack {
            Circle()
                .stroke(lineWidth: 20)
                .opacity(0.3)
                .foregroundColor(Color.gray.opacity(0.5))
            
            Circle()
                .trim(from: 0, to: CGFloat(Double(progressPercent)))
                .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                .foregroundColor(color)
                .rotationEffect(Angle(degrees: -90))
                .animation(.linear)
                        
            VStack {
                Text("\(progressPercent)")
                    .font(.system(size: 40))
                    .foregroundColor(color)
                    .bold()
                Text(title)
                    .font(.headline)
                    .foregroundColor(Color.gray)
            }
        }
        .frame(width: 150, height: 150)
        .padding()
        .background(Color.white)
        .cornerRadius(20)
    }
}

struct ProgressCircleView1_Previews: PreviewProvider {
    static var previews: some View {
        ProgressCircleView1(progress: 75, color: .green, title: "Group")
    }
}
