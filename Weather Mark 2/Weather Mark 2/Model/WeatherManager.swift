//
//  WeatherManager.swift
//  Weather Mark 2
//
//  Created by Balaji Srinivas on 23/03/23.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=9b7130513f9dfe01e30b94fc4c277b75&units=metric&q="
    let weatherURLloc = "https://api.openweathermap.org/data/2.5/weather?appid=9b7130513f9dfe01e30b94fc4c277b75&units=metric&"
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather (cityName: String) {
        let urlString = "\(weatherURL)\(cityName)"
        performRequest(with: urlString)
    }
    func fetchWeather (lat: CLLocationDegrees, lon: CLLocationDegrees) {
        let urlString = "\(weatherURLloc)lat=\(lat)&lon=\(lon)"
        performRequest(with: urlString)
    }
    
    func performRequest (with urlString: String){
        if let url = URL(string:urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil{
                    delegate?.didFailWithError(error: error!)
                    return
                } else {
                    if let safeData = data{
                        if let weather = parseJSON(safeData){
                            delegate?.didUpdateWeather(self, weather: weather)
                                
                            }
                        }
                                            
                }
            }
            task.resume()
            
        }
    }
    func parseJSON(_ weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData   = try decoder.decode(WeatherData.self, from: weatherData)
            
            let cityName      = decodedData.name
            let id            = decodedData.weather[0].id
            let temp          = decodedData.main.temp
            let feelsLikeTemp = decodedData.main.feels_like
            let maxTemp       = decodedData.main.temp_max
            let minTemp       = decodedData.main.temp_min
            let windSpeed     = decodedData.wind.speed
            let windDirection = decodedData.wind.deg
            let visibility    = decodedData.visibility
            let humidity      = decodedData.main.humidity
            
            let weather = WeatherModel(conditionId: id, cityName: cityName, temperature: temp, feelsLikeTemp: feelsLikeTemp, maxTemp: maxTemp, minTemp: minTemp, windSpeed: windSpeed, windDirection: windDirection, visibility: visibility, humidity: humidity)
            return weather
            
        } catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
  
}
