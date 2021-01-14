//
//  ContentView.swift
//  Shared
//
//  Created by Filip Wicha on 10/01/2021.
//


import SwiftUI

struct ContentView: View {
    
    @ObservedObject var basicViewModel: BasicViewModel = BasicViewModel()
    @State var showAlert = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack{
            VStack{
                Slider(
                    value: self.$basicViewModel.percent.value,
                    in: 0...100,
                    step: 1,
                    onEditingChanged: { editing in
                        if (!editing){
                            self.basicViewModel.setPercent()
                        }
                    },
                    minimumValueLabel: Text("Off"),
                    maximumValueLabel: Text("100")
                ) {
                    
                }
                Text(String(self.basicViewModel.weather.temp))
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

