//
//  RegSecond.swift
//  CampusKey
//
//  Created by Anthony Lopez on 10/29/20.
//

import UIKit

class RegSecond: UIViewController {

    @IBOutlet weak var showEmail: UILabel!
    var email = ""

    
    
    @IBAction func VerifyButton(_ sender: Any) {
    }
    
    
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

        showEmail?.text = email
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
