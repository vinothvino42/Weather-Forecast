//
//  VVGooglePlaceTextField.swift
//  VVGooglePlaceTextField
//
//  Created by Vinoth Vino on 27/06/18.
//  Copyright © 2018 Vinoth Vino. All rights reserved.
//

import UIKit
import GooglePlaces

public class VVGooglePlaceTextField: UITextField {

    var googlePlaces = [String]()
    var vvgooglePlaceView = VVGooglePlaceView()
    var vvgooglePlaceViewHeightConstraint = NSLayoutConstraint()
    var isOpen = false
    public var vvgooglePlaceViewHeight: CGFloat = 200
    
    override public func awakeFromNib() {
        vvgooglePlaceView = VVGooglePlaceView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        vvgooglePlaceView.delegate = self
        vvgooglePlaceView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override public func didMoveToWindow() {
        self.superview?.addSubview(vvgooglePlaceView)
        self.superview?.bringSubview(toFront: vvgooglePlaceView)
        vvgooglePlaceView.topAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        vvgooglePlaceView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        vvgooglePlaceView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        vvgooglePlaceViewHeightConstraint = vvgooglePlaceView.heightAnchor.constraint(equalToConstant: 0)
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.placeholder = ""
        self.textAlignment = .left
        if isOpen == false {
            isOpen = true
            NSLayoutConstraint.deactivate([self.vvgooglePlaceViewHeightConstraint])
            if self.vvgooglePlaceView.tableView.contentSize.height > vvgooglePlaceViewHeight {
                self.vvgooglePlaceViewHeightConstraint.constant = vvgooglePlaceViewHeight
            } else {
                self.vvgooglePlaceViewHeightConstraint.constant = self.vvgooglePlaceView.tableView.contentSize.height
            }
            NSLayoutConstraint.activate([self.vvgooglePlaceViewHeightConstraint])
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.vvgooglePlaceView.layoutIfNeeded()
                self.vvgooglePlaceView.center.y += self.vvgooglePlaceView.frame.height / 2
            }, completion: nil)
        }
    }
    
    public func dismissVVGooglePlaceView() {
        isOpen = false
        NSLayoutConstraint.deactivate([self.vvgooglePlaceViewHeightConstraint])
        self.vvgooglePlaceViewHeightConstraint.constant = 0
        NSLayoutConstraint.activate([self.vvgooglePlaceViewHeightConstraint])
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.vvgooglePlaceView.center.y -= self.vvgooglePlaceView.frame.height
            self.vvgooglePlaceView.layoutIfNeeded()
        }, completion: nil)
    }
    
    @objc public func getDataFromGooglePlaces() {
        self.googlePlaces.removeAll()
        
        if self.text == "" {
            dismissVVGooglePlaceView()
        }
        //let filter = GMSAutocompleteFilter()
        //filter.type = .city
        let placesClient = GMSPlacesClient()
        placesClient.autocompleteQuery(self.text!, bounds: nil, filter: nil) { (resultsFromGooglePlaces, error) in
            if let error = error {
                print("Autocomplete error: ",error)
                return
            }
            if let results = resultsFromGooglePlaces {
                for result in results {
                    
                    self.googlePlaces.append(result.attributedPrimaryText.string)
                    self.vvgooglePlaceView.datas = self.googlePlaces
                    
                    NSLayoutConstraint.deactivate([self.vvgooglePlaceViewHeightConstraint])
                    if self.vvgooglePlaceView.tableView.contentSize.height > self.vvgooglePlaceViewHeight {
                        self.vvgooglePlaceViewHeightConstraint.constant = self.vvgooglePlaceViewHeight
                    } else {
                        self.vvgooglePlaceViewHeightConstraint.constant = self.vvgooglePlaceView.tableView.contentSize.height
                    }
                    NSLayoutConstraint.activate([self.vvgooglePlaceViewHeightConstraint])
                    
                    self.vvgooglePlaceView.tableView.reloadData()
                }
            }
        }
    }
}

extension VVGooglePlaceTextField: VVGooglePlaceProtocol {
    
    func googlePlaceCellPressed(data: String) {
        self.text = data
        self.dismissVVGooglePlaceView()
    }
}
