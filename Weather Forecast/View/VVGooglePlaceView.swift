//
//  VVGooglePlaceView.swift
//  VVGooglePlaceTextField
//
//  Created by Vinoth Vino on 28/06/18.
//  Copyright © 2018 Vinoth Vino. All rights reserved.
//

import UIKit

protocol VVGooglePlaceProtocol {
    func googlePlaceCellPressed(data: String)
}

class VVGooglePlaceView: UIView {

    var datas = [String]()
    var tableView = UITableView()
    var delegate: VVGooglePlaceProtocol!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableView.backgroundColor = UIColor.white
        self.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableView)
        
        tableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension VVGooglePlaceView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = datas[indexPath.row]
        cell.backgroundColor = UIColor.white
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate.googlePlaceCellPressed(data: datas[indexPath.row])
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}
