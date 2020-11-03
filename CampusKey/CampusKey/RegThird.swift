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
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return enterPassword.resignFirstResponder()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showEmail?.text = email
        self.enterPassword.delegate = self
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