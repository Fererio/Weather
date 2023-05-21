//
//  WeatherModel.swift
//  Weather Mark 2
//
//  Created by Balaji Srinivas on 23/03/23.
//

import Foundation
struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let feelsLikeTemp: Double
    let maxTemp: Double
    let minTemp: Double
    let windSpeed:Double
    let windDirection: Int
    let visibility: Int
    let humidity: Int
    var tempString: String {
        return String(format: "%.2f", temperature)
    }
    var feelsLikeTempString: String {
        return String(format: "%.2f", feelsLikeTemp)
    }
    var maxTempString: String {
        return String(format: "%.2f", maxTemp)
    }
    var minTempString: String {
        return String(format: "%.2f", minTemp)
    }
    var windSpeedString: String {
        return String(format: "%.2f", windSpeed)
    }
 
    var conditionName: String {
        switch conditionId{
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701:
            return "cloud.fog"
        case 711:
            return "smoke"
        case 721:
            return "sun.haze"
        case 731:
            return "sun.dust"
        case 741:
            return "cloud.fog"
        case 751...771:
            return "sun.dust"
        case 781:
            return "tornado"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud"
        default:
            return "sun.min"
        }
    }
    
    
}
