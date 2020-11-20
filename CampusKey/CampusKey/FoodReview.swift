//
//  FoodReview.swift
//  CampusKey
//
//  Created by Anthony Lopez on 11/17/20.
//

import UIKit

class FoodReview: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var ratingWord: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var usrReviewTextField: UITextField!
    @IBOutlet weak var submitRateBtn: UIButton!
    
    var image = UIImage()
    var name = ""
 
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        
        rating.text = "\(currentValue)"
        
        if currentValue <= 4
            {ratingWord.text = "POOR"}
        else if currentValue == 5 || currentValue == 6
            {ratingWord.text = "AVERAGE"}
        else if currentValue == 7 || currentValue == 8
            {ratingWord.text = "GREAT"}
        else if currentValue >= 9
            {ratingWord.text = "AMAZING"}
        
    }
    
    //<KEYBOARD FUNCTIONS>
    @objc func keyboardWillShow(notification: NSNotification) {
            
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
           // if keyboard size is not available for some reason, dont do anything
           return
        }
      
      // move the root view up by the distance of keyboard height
      self.view.frame.origin.y = 0 - keyboardSize.height
    }

    @objc func keyboardWillHide(notification: NSNotification) {
      // move back the root view origin to zero
      self.view.frame.origin.y = 0
    }
   
    //Closes keyboard when return button is pushed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usrReviewTextField
            {return usrReviewTextField.resignFirstResponder()}

        return true
        
    }
    
    //VIEW LOADER #################################################
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodName.text = name
        foodImage.image = image
        usrReviewTextField.delegate = self
        
        submitRateBtn.layer.cornerRadius = 4
        
        // call the 'keyboardWillShow' function when the view controller receive the notification that a keyboard is going to be shown
        NotificationCenter.default.addObserver(self, selector: #selector(FoodReview.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
      
          // call the 'keyboardWillHide' function when the view controlelr receive notification that keyboard is going to be hidden
        NotificationCenter.default.addObserver(self, selector: #selector(FoodReview.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        

    
    }
    

}
