//
//  RegGuest.swift
//  CampusKey
//
//  Created by Anthony Lopez on 11/4/20.
//

import UIKit

class RegGuest: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var emailHolder: UITextField!
    
    @IBOutlet weak var passwordHolder: UITextField!
    
    @IBAction func RegisterButton(_ sender: Any) {
    }
    
    //Lowers keyboard when return button in clicked on
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == emailHolder
            {return emailHolder.resignFirstResponder()}
        else if textField == passwordHolder
            {return passwordHolder.resignFirstResponder()}
        
        return true
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.emailHolder.delegate = self
        self.passwordHolder.delegate = self
        
        // Do any additional setup after loading the view.
    }
    

}
