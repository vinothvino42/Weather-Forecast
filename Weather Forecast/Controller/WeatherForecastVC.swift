//
//  ViewController.swift
//  Weather Forecast
//
//  Created by Vinoth Vino on 02/01/18.
//  Copyright © 2018 Vinoth Vino. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class WeatherForecastVC: UIViewController, CLLocationManagerDelegate {

    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let API_KEY = "YOUR OPEN WEATHER API KEY"
    
    //TODO: Declare instance variables
    let locationManager = CLLocationManager()
    let weatherModel = WeatherModel()
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO: Set up the location manager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = nil
    }
    
    //MARK: - Networking
    func getWeatherData(url: String, parameters: [String : String]) {
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { (response) in
            if response.result.isSuccess {
                print("Success")
                
                let weatherJSON: JSON = JSON(response.result.value!)
                self.updateWeatherData(jsonData: weatherJSON)
                
            } else {
                
                print("Error : \(response.result.error)")
                self.cityLabel.text = "Connection Failed"
            }
        }
    }

    //MARK: - JSON Parsing
    func updateWeatherData(jsonData: JSON) {
        
        if let tempResult = jsonData["main"]["temp"].double {
            weatherModel.temperature = Int(tempResult - 273.15)
            weatherModel.city = jsonData["name"].stringValue
            weatherModel.condition = jsonData["weather"][0]["id"].intValue
            weatherModel.weatherImageName = weatherModel.updateWeatherIcon(condition: weatherModel.condition)
        } else {
            cityLabel.text = "Weather Unavailable"
        }
    }
    
    //MARK: - Location Manager Delegate Methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            print("Latitude : \(location.coordinate.latitude) and Longitude : \(location.coordinate.longitude)")
            
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            
            let params: [String : String] = ["lat" : latitude, "lon" : longitude, "appid" : API_KEY]
            
            getWeatherData(url: WEATHER_URL, parameters: params)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
        cityLabel.text = "Location Unavailable"
    }
}

