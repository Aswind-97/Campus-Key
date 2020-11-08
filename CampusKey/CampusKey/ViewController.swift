//
//  ViewController.swift
//  CampusKey
//
//  Created by Anthony Lopez on 10/22/20.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var emailHolder: UITextField!
    
    @IBOutlet weak var passwordHolder: UITextField!
    
    @IBAction func signInButton(_ sender: Any) {
    }
    
    @IBAction func forgotPasswordButton(_ sender: Any) {
    }
    
    @IBAction func registerButton(_ sender: Any) {
    }
    
    
    //Closes keyboard when return button is pushed
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

