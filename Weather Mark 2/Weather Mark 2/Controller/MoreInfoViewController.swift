//
//  MoreInfoViewController.swift
//  Weather Mark 2
//
//  Created by Balaji Srinivas on 23/03/23.
//

import UIKit

class MoreInfoViewController: UIViewController {
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var conditionImage: UIImageView!
    
    
    var cityName: String?
    var maxTemp: String?
    var minTemp: String?
    var windSpeed: String?
    var windDirection: String?
    var visibility: String?
    var humidity: String?
    var conditionImageString: String?
    
    @IBOutlet var minTempLabel: UILabel!
    @IBOutlet var maxTempLabel: UILabel!
    @IBOutlet var windSpeedLabel: UILabel!
    @IBOutlet var windDirectionLabel: UILabel!
    @IBOutlet var visibilityLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        cityLabel.text = cityName
        conditionImage.image = UIImage(systemName: conditionImageString!)
        minTempLabel.text = "\(minTemp!)" + " °C"
        maxTempLabel.text = "\(maxTemp!)" + " °C"
        windSpeedLabel.text = "\(windSpeed!)" + " m/s"
        humidityLabel.text = "\(humidity!)" + " %"
        visibilityLabel.text = "\(visibility!)" + " m"
        windDirectionLabel.text = "\(windDirection!)" + " °"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
