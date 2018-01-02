//
//  ViewController.swift
//  Weather Forecast
//
//  Created by Vinoth Vino on 02/01/18.
//  Copyright © 2018 Vinoth Vino. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherForecastVC: UIViewController, CLLocationManagerDelegate {

    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let API_KEY = "bb57d5886df3df79bf4d61ebc1d4eb5b"
    
    //TODO: Declare instance variables
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO: Set up the location manager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
    }

}

