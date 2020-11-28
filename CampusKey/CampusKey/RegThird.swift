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
    @IBOutlet weak var registerBtn: UIButton!
    
    
    
    //Closes keyboard when return button is clicked on
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return enterPassword.resignFirstResponder()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Info gathered from previous view
        showEmail?.text = email
        
        self.enterPassword.delegate = self

        enterPassword.layer.cornerRadius = 8
        enterPassword.layer.shadowOpacity = 0.8
        enterPassword.layer.shadowOffset = CGSize(width: 1, height: 1)
        
        registerBtn.layer.cornerRadius = 8
        registerBtn.layer.shadowOpacity = 0.8
        registerBtn.layer.shadowOffset = CGSize(width: 1, height: 1)
        
        

    }
    

}
