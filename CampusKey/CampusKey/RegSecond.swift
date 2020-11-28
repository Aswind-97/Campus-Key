//
//  RegSecond.swift
//  CampusKey
//
//  Created by Anthony Lopez on 10/29/20.
//

import UIKit

class RegSecond: UIViewController{

    var email = ""
    
    @IBOutlet weak var showEmail: UILabel!
    @IBOutlet weak var codeInput: UITextField!
    @IBOutlet weak var verifyBtn: UIButton!
    
    @IBAction func VerifyButton(_ sender: Any) {
    }
    
    
    //Prepares info for next view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is RegThird
        {
            let vc = segue.destination as? RegThird
            vc?.email = showEmail.text!
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Grabs info from previous view
        showEmail?.text = email

        codeInput.layer.cornerRadius = 8
        codeInput.layer.shadowOpacity = 0.8
        codeInput.layer.shadowOffset = CGSize(width: 1, height: 1)
        
        verifyBtn.layer.cornerRadius = 8
        verifyBtn.layer.shadowOpacity = 0.8
        verifyBtn.layer.shadowOffset = CGSize(width: 1, height: 1)
        
        
    }
    


}
