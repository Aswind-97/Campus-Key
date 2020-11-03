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
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return emailHolder.resignFirstResponder()
    }
    
    
    
    
    
    
    
    
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}