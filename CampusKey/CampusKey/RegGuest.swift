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
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet var myTexts: [UITextField]!
    
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
        
        registerBtn.layer.cornerRadius = 8
        registerBtn.layer.shadowOpacity = 0.8
        registerBtn.layer.shadowOffset = CGSize(width: 1, height: 1)
        
        for text in self.myTexts{
            text.layer.cornerRadius = 8
            text.layer.shadowOpacity = 0.8
            text.layer.shadowOffset = CGSize(width: 1, height: 1)
        }
        
        
    }
    

}
