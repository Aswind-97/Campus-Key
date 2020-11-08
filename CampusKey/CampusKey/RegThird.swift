//
//  RegThird.swift
//  CampusKey
//
//  Created by Anthony Lopez on 10/29/20.
//

import UIKit

class RegThird: UIViewController, UITextFieldDelegate {

    
    var email = ""
    
    @IBOutlet weak var showEmail: UILabel!
    
    @IBOutlet weak var enterPassword: UITextField!
    
    
    
    //Closes keyboard when return button is clicked on
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return enterPassword.resignFirstResponder()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Info gathered from previous view
        showEmail?.text = email
        
        self.enterPassword.delegate = self
        // Do any additional setup after loading the view.
    }
    

}
