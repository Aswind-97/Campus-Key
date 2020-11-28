//
//  RegPathPicker.swift
//  CampusKey
//
//  Created by Anthony Lopez on 11/28/20.
//

import UIKit

class RegPathPicker: UIViewController {

    @IBOutlet var myButtons: [UIButton]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for button in self.myButtons{
            button.layer.cornerRadius = 8
            button.layer.shadowOpacity = 0.8
            button.layer.shadowOffset = CGSize(width: 1, height: 1)
        }
        
    }
    



}
