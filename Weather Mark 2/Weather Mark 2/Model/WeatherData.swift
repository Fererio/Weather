//
//  WeatherData.swift
//  Weather Mark 2
//
//  Created by Balaji Srinivas on 23/03/23.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let visibility: Int
    let wind: Wind
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let humidity: Int
}
struct Weather: Codable {
//    let description: String
    let id: Int
}
struct Wind: Codable {
    let speed: Double
    let deg: Int
}
