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
                VStack{
                    HStack{
                        Text("set heating")
                            .padding(.top, 15)
                            .padding(.trailing, 15)
                            .padding(.leading, 15)
                        Spacer()
                    }
                    VStack {
                        Slider(
                            value: self.$basicViewModel.percent.value,
                            in: 0...100,
                            onEditingChanged: { editing in
                                if (!editing){
                                    self.basicViewModel.setPercent()
                                }
                            },
                            minimumValueLabel: Text("off"),
                            maximumValueLabel:
                                Text((self.basicViewModel.percent.value != 100) ? String(Int(self.basicViewModel.percent.value)) : "max")
                        ) {}
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(LinearGradient(gradient: Gradient(colors: [Color("Blue"), Color("Red")]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(40)
                    .shadow( radius: 55.0)
                    .padding()
                }
                .background(Color("DarkGray"))
                .cornerRadius(40)
                .shadow( radius: 5.0)
                .padding(.bottom, 20)
                
                HStack{
                    Block(name: "temperature", symbol: "thermometer", value: String(Int(self.basicViewModel.weather.temp)) + " °C")
                    Block(name: "humidity", symbol: "drop", value: String(Int(self.basicViewModel.weather.humidity)) + " %")
                    
                }
                
                HStack{
                    Block(name: "pressure", symbol: "arrow.down.to.line", value: String(Int(self.basicViewModel.weather.pressure)) + " hPa")
                    Block(name: "wind speed", symbol: "wind", value: String(Int(self.basicViewModel.weather.speed)) + " m/s")
                }
                
                HStack{
                    
                    Block(name: "wind gust", symbol: "speedometer", value: String(Int(self.basicViewModel.weather.gust)) + " m/s")
                    Block(name: "wind direction", symbol: "arrow.up.left.circle", value: String(self.basicViewModel.weather.deg) + "°", degree: (self.basicViewModel.weather.deg + 45))
                }
                
                Slide(thumbnailColor: Color.red,
                              didReachEndAction: { view in
                                print("Update")
                                self.basicViewModel.getWeatherData()
                                DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                                    view.resetState()
                                }
                              })
                    .frame(width: 240, height: 56)
                    .background(Color.yellow)
                    .cornerRadius(28)
                
            }.frame(width: 350, height: 100, alignment: .center)
            
           
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Warning"), message: Text("Could not find requested node, switching to Node1"), dismissButton: .default(Text("Got it!")))
        }
    }
}


struct Block: View {
    var name: String
    var symbol: String
    var value: String
    var degree: Int = 0
    
    var body: some View {
        VStack{
            Text(name)
                .font(.title3)
                .foregroundColor(Color("Gray"))
            Text(value)
                .font(.title)
                .bold()
            Image(systemName: symbol)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .rotationEffect(.degrees(Double(degree)))
                .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/)
                .foregroundColor(Color("Gray"))
        }
        .frame(width: 170, height: 170, alignment: .center)
        .background(Color("DarkGray"))
        .cornerRadius(20)
        .shadow( radius: 5.0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView().environment(\.colorScheme, .dark)
        }
    }
}

