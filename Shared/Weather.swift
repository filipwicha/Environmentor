//
//  Weather.swift
//  Shared
//
//  Created by Filip Wicha on 10/01/2021.
//


import Foundation

struct Weather: Codable {
    
    let main: Main
    let wind: Wind
    let dt: Int
}

struct Main: Codable {
    
    let temp: Double
    let pressure: Int
    let humidity: Double
}

struct Wind: Codable {
    
    let speed: Double
    let gust: Double
    let deg: Int
}

struct Percent: Codable {
    var value: Int
}
