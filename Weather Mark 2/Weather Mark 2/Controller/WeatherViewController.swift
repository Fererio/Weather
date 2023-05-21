//
//  ViewController.swift
//  Weather Mark 2
//
//  Created by Balaji Srinivas on 20/03/23.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    
    var cityName = "Hyderabad"
    var maxTemp = "30"
    var minTemp = "30"
    var windSpeed = "1"
    var windDirection = "1"
    var humidity = "1"
    var visibility = "1"
    var conditionImageViewString = "cloud.bolt"
    var lat: CLLocationDegrees = 0.0
    var lon: CLLocationDegrees = 0.0
    @IBOutlet var conditionImageView: UIImageView!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    
    @IBOutlet var feelsLikeTemperatureLabel: UILabel!
    @IBOutlet var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.requestLocation()
        
        
        weatherManager.delegate = self
        searchTextField.delegate = self
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToMoreInfo" {
            let destinationVC = segue.destination as! MoreInfoViewController
            destinationVC.cityName = cityName
            destinationVC.humidity = humidity
            destinationVC.maxTemp = maxTemp
            destinationVC.minTemp = minTemp
            destinationVC.visibility = visibility
            destinationVC.windDirection = windDirection
            destinationVC.windSpeed = windSpeed
            destinationVC.conditionImageString = conditionImageViewString
            
        }
    }
}

//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    @IBAction func moreInfoPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToMoreInfo", sender: self)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Enter the City Name"
            return false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text{
            weatherManager.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
    }
}
//MARK: - WeathermanagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.tempString + " °C"
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
            self.feelsLikeTemperatureLabel.text = "Feels like " + weather.feelsLikeTempString + " °C"
            self.cityName = weather.cityName
            self.minTemp = String(format: "%.2f",weather.minTemp )
            self.maxTemp = String(format: "%.2f", weather.maxTemp)
            self.windSpeed = String(format: "%.2f", weather.windSpeed)
            self.humidity = String(weather.humidity)
            self.visibility = String(weather.visibility)
            self.windDirection = String(weather.windDirection)
            self.conditionImageViewString = weather.conditionName
        }
        
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            lat = location.coordinate.latitude
            lon = location.coordinate.longitude
            weatherManager.fetchWeather(lat: lat, lon: lon)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
}
