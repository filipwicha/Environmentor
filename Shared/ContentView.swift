//
//  ContentView.swift
//  Shared
//
//  Created by Filip Wicha on 10/01/2021.
//


import SwiftUI

struct ContentView: View {
    
    @ObservedObject var basicViewModel: BasicViewModel = BasicViewModel()
    @State var node = "Node1"
    @State var showAlert = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack{
            VStack{
                Text(String(self.basicViewModel.weather.temp))
                TextField("Node1", text: self.$node).multilineTextAlignment(.center)
                Button(action: {
                    self.basicViewModel.getWeatherData()
                }){
                    Text("Change").foregroundColor(.gray)
                }
            }.frame(width: 300, height: 100, alignment: .center)
            
            Text(" ")
            Text(" ")
            Text(" ")
            Text("How long do you work?")
            
        }
        .alert(isPresented: $showAlert) {
                Alert(title: Text("Warning"), message: Text("Could not find requested node, switching to Node1"), dismissButton: .default(Text("Got it!")))
            }
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

