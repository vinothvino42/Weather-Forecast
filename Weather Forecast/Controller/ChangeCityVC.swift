//
//  ChangeCityVC.swift
//  Weather Forecast
//
//  Created by Vinoth Vino on 02/01/18.
//  Copyright © 2018 Vinoth Vino. All rights reserved.
//

import UIKit

protocol ChangeCityDelegate {
    func userEnteredNewCityName(city: String)
}

class ChangeCityVC: UIViewController {

    var delegate: ChangeCityDelegate?
    
    @IBOutlet weak var cityTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func getWeatherTapped(_ sender: Any) {
        DispatchQueue.main.async {
            let cityName = self.cityTextField.text!
            self.delegate?.userEnteredNewCityName(city: cityName)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
