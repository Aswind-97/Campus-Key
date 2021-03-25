//
//  LocationsControl.swift
//  CampusKey
//
//  Created by Anthony Lopez on 11/30/20.
//

import UIKit

class LocationsControl: UIViewController {

    @IBOutlet var myButtons: [UIButton]!
    
    var usrAccess = ""
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is FoodList
        {
            let vc = segue.destination as? FoodList
            vc?.usrAccess = usrAccess
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for button in self.myButtons{
            button.layer.cornerRadius = 8
            button.layer.shadowOpacity = 0.8
            button.layer.shadowOffset = CGSize(width: 1, height: 1)
            button.backgroundColor = UIColor.systemRed
            button.layer.opacity = (0.95)

            self.title = "LOCATIONS"
        }
 
 }
    



}
