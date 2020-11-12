//
//  RegMain.swift
//  CampusKey
//
//  Created by Anthony Lopez on 10/29/20.
//

import UIKit

class RegMain: UIViewController, UITextFieldDelegate {
    
    var email:String?
    var firstName:String = "Javier"
    var verified:Bool = false
    
    @IBOutlet weak var emailHolder: UITextField!
    
    @IBAction func ContinueButton(_ sender: Any) {
        
        //Hit the API endpoint
        email = emailHolder.text
        print(email ?? "")
        let urlString = "https://api.metalab.csun.edu/directory/api/members?email=" + email! //javier.aguayo.882@my.csun.edu
        print(urlString)

        let url = URL(string: urlString)

        guard url != nil else {
            return
        }
        let session = URLSession.shared

        let dataTask = session.dataTask(with: url!) { (data, response, error) in

            if error == nil && data != nil{
                //pasre JSON
                let decoder = JSONDecoder()
                do{

                    let members = try decoder.decode(Members.self, from: data!)
                    print(members.people?.first_name ?? "")//.people?.first_name ?? ""
                    if(members.people?.first_name == self.firstName){
                        print("first name matches")
                        self.verified = true
//                        performSegue(withIdentifier: "Verify info", sender: self)
                    }
                    else{
                        return print("Error first name does not match")
                    }
                }
                catch{
                    print("Error  in JSON parsing")
                }
            }
        }

        //Make API call
        dataTask.resume()
        if verified{
            let firstNameAlert = UIAlertController(title: "First Name did not match", message: "Please correct first name.",       preferredStyle: .alert)
            firstNameAlert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            }))
            self.present(firstNameAlert, animated: true, completion: nil)
        }else{

            performSegue(withIdentifier: "Verify info", sender: self)
        }
    
    //Closes keyboard when return button is pushed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return emailHolder.resignFirstResponder()
    }
    
    
    //Prepares info for next view
        func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is RegSecond
        {
            let vc = segue.destination as? RegSecond
            vc?.email = emailHolder.text!
        }
    }
    
    
    
    
        func viewDidLoad() {
        super.viewDidLoad()
        
        self.emailHolder.delegate = self
        // Do any additional setup after loading the view.
        
        //Hit the API endpoint
//        print(email)
//        let urlString = "https://api.metalab.csun.edu/directory/api/members?email=" + email //javier.aguayo.882@my.csun.edu
//        print(urlString)
//
//        let url = URL(string: urlString)
//
//        guard url != nil else {
//            return
//        }
//        let session = URLSession.shared
//
//        let dataTask = session.dataTask(with: url!) { (data, response, error) in
//
//            if error == nil && data != nil{
//                //pasre JSON
//                let decoder = JSONDecoder()
//                do{
//
//                    let members = try decoder.decode(Members.self, from: data!)
//                    print(members)
//                }
//                catch{
//                    print("Error  in JSON parsing")
//                }
//            }
//        }
//        //Make API call
//        dataTask.resume()
    }
    

}
}
