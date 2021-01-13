//
//  BasicViewModel.swift
//  Shared
//
//  Created by Filip Wicha on 10/01/2021.
//

import Foundation

class BasicViewModel: ObservableObject {
       
    @Published var weather: WeatherViewModel = WeatherViewModel(weather: Weather(main: Main(temp: 0.0, pressure: 0, humidity: 0.0), wind: Wind(speed: 0.0, gust: 0.0, deg: 0), dt: 0))
    @Published var regularPost: Int = 8

    init() {
        getWeatherData()
    }
    
    func getWeatherData() {
        
        Webservice().getData { weather in
            if let weather = weather {
                self.weather = WeatherViewModel.init(weather: weather)
            }
        }
    }
}

func getCurrentDateString() -> String{
    let today = Date()
    let formatter1 = DateFormatter()
    formatter1.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    return formatter1.string(from: today)
}

class WeatherViewModel {
    
    var weather: Weather
    
    init(weather: Weather){
        self.weather = weather
    }
    
    var temp: Double {
        return self.weather.main.temp
    }
    
    var pressure: Int {
        return self.weather.main.pressure
    }
    
    var humidity: Double {
        return self.weather.main.humidity
    }
    
    var speed: Double {
        return self.weather.wind.speed
    }
    
    var gust: Double {
        return self.weather.wind.gust
    }
    
    var deg: Int {
        return self.weather.wind.deg
    }
     
    var date: Date {
        return Date(milliseconds: self.weather.dt)
    }
}

extension Date {
    var millisecondsSince1970:Int {
        return Int((self.timeIntervalSince1970 * 1000.0).rounded())
    }

    init(milliseconds: Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}



