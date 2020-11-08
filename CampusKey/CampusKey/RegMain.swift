//
//  RegMain.swift
//  CampusKey
//
//  Created by Anthony Lopez on 10/29/20.
//

import UIKit

class RegMain: UIViewController, UITextFieldDelegate {
    
    var email = ""
    
    @IBOutlet weak var emailHolder: UITextField!
    
    @IBAction func ContinueButton(_ sender: Any) {
    }
    
    //Closes keyboard when return button is pushed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return emailHolder.resignFirstResponder()
    }
    
    //Prepares info for next view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is RegSecond
        {
            let vc = segue.destination as? RegSecond
            vc?.email = emailHolder.text!
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.emailHolder.delegate = self
        // Do any additional setup after loading the view.
    }
    

}
