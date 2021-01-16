//
//  Weather.swift
//  Shared
//
//  Created by Filip Wicha on 10/01/2021.
//


import Foundation

struct Weather: Codable {
    
    var main: Main
    var wind: Wind
    var dt: Int
}

struct Main: Codable {
    
    var temp: Double
    var pressure: Int
    var humidity: Double
}

struct Wind: Codable {
    
    var speed: Double
    var gust: Double
    var deg: Int
}

struct Percent: Codable {
    var value: Int
}
