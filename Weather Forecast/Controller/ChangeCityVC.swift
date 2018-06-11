//
//  ChangeCityVC.swift
//  Weather Forecast
//
//  Created by Vinoth Vino on 02/01/18.
//  Copyright © 2018 Vinoth Vino. All rights reserved.
//

import UIKit
import GooglePlaces

protocol ChangeCityDelegate {
    func userEnteredNewCityName(city: String)
}

class ChangeCityVC: UIViewController, UISearchControllerDelegate {
    
    var delegate: ChangeCityDelegate?
    @IBOutlet weak var googlePlacesTextField: RVGooglePlacesTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        googlePlacesTextField.highLightTypeTextedEnabled = true
        
        //For Getting selected place and indexPath
        googlePlacesTextField.selectedPlace = { place , indexPath in
            print("SELECTED PLACE : \(place)")
            print("INDEXPATH : \(indexPath)")
            let cityName = place
            //self.delegate?.userEnteredNewCityName(city: cityName)
        }
        
    }
 
    @IBAction func getWeatherTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
  
}
