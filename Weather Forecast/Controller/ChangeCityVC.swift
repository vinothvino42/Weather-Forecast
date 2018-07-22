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
  
    @IBOutlet weak var cityTextField: VVGooglePlaceTextField!
    var delegate: ChangeCityDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityTextField.addTarget(cityTextField, action: #selector(cityTextField.getDataFromGooglePlaces), for: .editingChanged)
        cityTextField.attributedPlaceholder = NSAttributedString(string: "Enter your city name..", attributes: [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.boldSystemFont(ofSize: 17.0)
            ])
        cityTextField.vvgooglePlaceViewHeight = 200
    
    }
    

    @IBAction func getWeatherTapped(_ sender: Any) {
        DispatchQueue.main.async {
            let cityName = self.cityTextField.text!
            self.delegate?.userEnteredNewCityName(city: cityName)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
  
}

