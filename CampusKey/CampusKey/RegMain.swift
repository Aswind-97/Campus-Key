//
//  RegMain.swift
//  CampusKey
//
//  Created by Anthony Lopez on 10/29/20.
//

import UIKit

class RegMain: UIViewController, UITextFieldDelegate {
    
    var email:String = ""
    var idNum:String = "members:"
    var firstName:String = "wrong"
    var lastName:String = ""
    var verified:Int = 0
    var failure:String = ""
    
    //@IBOutlet weak var emailHolderInput: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var emailHolder: UITextField!
    @IBOutlet weak var idNumber: UITextField!
    @IBOutlet weak var firstNameInput: UITextField!
    @IBOutlet weak var lastNameInput: UITextField!
    
    @IBAction func ContinueButton(_ sender: Any) {
        
        //Hit the API endpoint
        email = emailHolder.text!
        idNum += idNumber.text!
        firstName = firstNameInput.text!
        lastName = lastNameInput.text!
        
        print("email as: " + email)
        print("id number " + idNum)
        print("first Name: " + firstName)
        print("last name: " + lastName)
        print("verified as:" , verified)
        
        DispatchQueue.main.async {

            self.fetchMemberData{ (members) in

            print(members.people?.individuals_id ?? "")
            print(members.people?.first_name ?? "")
            print(members.people?.last_name ?? "")
            }
        }
        
        spinner.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {
            // your code here
        
            self.spinner.stopAnimating()
            print("after resume before last if " , self.verified)
            if self.verified == 1{
                self.completeSegue()
            }
            else if(self.verified != 1){
                self.clearData()
            let firstNameAlert = UIAlertController(title: "Information did not match", message: "Please correct, then try again.",       preferredStyle: .alert)
            firstNameAlert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            }))
            self.present(firstNameAlert, animated: true, completion: nil)
        }
            
        }
    }
    func delay(interval: TimeInterval, closure: @escaping () -> Void) {
         DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
              closure()
         }
    }
    func fetchMemberData(completionHandler: @escaping (Members) -> Void){
        
        let urlString = "https://api.metalab.csun.edu/directory/api/members?email=" + email //javier.aguayo.882@my.csun.edu

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
                    
                    //while self.verified == 0{
                        if(members.people?.first_name == self.firstName && members.people?.last_name == self.lastName && members.people?.individuals_id == self.idNum){
                            DispatchQueue.main.async {
                            self.updateVerified()
                            }
                        }
                    completionHandler(members)
                }
                catch{
                    let error = error
                    print("Error  in JSON parsing", error.localizedDescription)
                }
            }
        }
        dataTask.resume()
    }
    
    func clearData(){
        email = ""
        idNum = "members:"
        firstName = "wrong"
        lastName = ""
    }
    func completeSegue(){
        performSegue(withIdentifier: "Verify info", sender: self)
    }
    func updateVerified(){
        print(self.verified)
        self.verified = 1
    }
    
    //<KEYBOARD FUNCTIONS>###############
    //Called when keyboard is clicked on in order to scroll view to allow textView to be shown
    @objc func keyboardWillShow(notification: NSNotification) {
            
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
           // if keyboard size is not available for some reason, dont do anything
           return
        }
      
      // move the root view up by the distance of keyboard height
      self.view.frame.origin.y = 125 - keyboardSize.height
    }

    @objc func keyboardWillHide(notification: NSNotification) {
      // move back the root view origin to zero
      self.view.frame.origin.y = 0
    }
    
    //Closes keyboard when return button is pushed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailHolder
            {return emailHolder.resignFirstResponder()}
        else if textField == idNumber
            {return idNumber.resignFirstResponder()}
        else if textField == firstNameInput
            {return firstNameInput.resignFirstResponder()}
        else if textField == lastNameInput
            {return lastNameInput.resignFirstResponder()}
        
        return true
        
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
        
        spinner.hidesWhenStopped = true
        self.emailHolder.delegate = self
        self.firstNameInput.delegate = self
        self.lastNameInput.delegate = self
        self.idNumber.delegate = self

        // call the 'keyboardWillShow' function when the view controller receive the notification that a keyboard is going to be shown
        NotificationCenter.default.addObserver(self, selector: #selector(FoodReview.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
      
          // call the 'keyboardWillHide' function when the view controlelr receive notification that keyboard is going to be hidden
        NotificationCenter.default.addObserver(self, selector: #selector(FoodReview.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    

}

