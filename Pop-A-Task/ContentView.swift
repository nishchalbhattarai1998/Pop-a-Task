//
//  ContentView.swift
//  Pop-A-Task
//
//  Created by nishchal bhattarai on 2023-01-16.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "lines.measurement.horizontal")
          
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Pop A Task").fontWeight(.bold)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
