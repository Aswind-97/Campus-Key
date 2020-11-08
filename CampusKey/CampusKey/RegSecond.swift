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
        // Do any additional setup after loading the view.
    }
    


}
