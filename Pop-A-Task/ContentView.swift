//
//  ContentView.swift
//  Pop-A-Task
//
//  Created by nishchal bhattarai on 2023-01-16.
//

import SwiftUI


struct ContentView: View {
    @State var email = "";
    @State var password = "";
    @State var name = "";
    var body: some View {
        NavigationView {
            
            VStack {
                //comment1
                Image(systemName: "lines.measurement.horizontal")
                    .padding(.top, 0.0)
                    .imageScale(.large)
                    .foregroundColor(.green)
                Text("Pop A Task").fontWeight(.bold)
                    .foregroundColor(.green)
                    .padding(.bottom, 400.0)
                Button("Login") {
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                }
                .fontWeight(.bold)
                .padding(0.0)
                .frame(width: 300.0, height: 50.0)
                .background(Color.green)
                .foregroundColor(Color.white)
                .cornerRadius(5.0)
                
                NavigationLink(destination: RegisterView()) {
                    Button("Sign Up") {
                        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                    }
                    .fontWeight(.bold)
                    .padding(0.0)
                    .frame(width: 300.0, height: 50.0)
                    .background(Color(hue: 0.343, saturation: 0.361, brightness: 0.978))
                    .foregroundColor(Color.green)
                    .cornerRadius(5.0)
                }
                
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


