//
//  LocationsControl.swift
//  CampusKey
//
//  Created by Anthony Lopez on 11/30/20.
//

import UIKit

class LocationsControl: UIViewController {

    @IBOutlet var myButtons: [UIButton]!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for button in self.myButtons{
            button.layer.cornerRadius = 8
            button.layer.shadowOpacity = 0.8
            button.layer.shadowOffset = CGSize(width: 1, height: 1)
            //button.backgroundColor = UIColor.lightGray
            button.backgroundColor = UIColor(red: 66.0/255, green: 236.0/255, blue: 245.0/255, alpha: 1.0)
        }
 
 }
    



}
