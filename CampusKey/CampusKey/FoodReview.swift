//
//  FoodReview.swift
//  CampusKey
//
//  Created by Anthony Lopez on 11/17/20.
//

import UIKit
import FirebaseDatabase

class FoodReview: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var ratingWord: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var usrReviewTextView: UITextView!
    @IBOutlet weak var submitRateBtn: UIButton!
    
    var image = UIImage()
    var name = ""
    var rated = 0
    var foodIdent = ""
    var newRatingStrings = [String]()
    var newReview = ""
    
    var refFoods: DatabaseReference!
    
    func addReview(){
        refFoods = Database.database().reference().child("food/\(foodIdent)/reviewStrings");
        
        refFoods.observeSingleEvent(of: .value, with: { snapshot in
            let allRestaurantsSnap = snapshot.children.allObjects as! [DataSnapshot] //contains all child nodes of food
            for arrNum in allRestaurantsSnap { //iterate over each restaurant node
                let reviewComments = arrNum.key //arborGrill, burgerKing etc
                let reviewString = arrNum.value as? String ?? ""
                
                self.newRatingStrings.append(reviewString)
                
                
            }
            self.newRatingStrings.append("This is the review in the text box")
            
        })
    }

    //Should return to previous view with usr's updated review
    @IBAction func submitRateBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
        print(newRatingStrings)
        refFoods.setValue(newRatingStrings)
    }
    
    //Controls actions when slider is changed by usr
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        
        rating.text = "\(currentValue)"
        
        if currentValue <= 3
            {ratingWord.text = "POOR"}
        else if currentValue == 4 || currentValue == 5 || currentValue == 6
            {ratingWord.text = "AVERAGE"}
        else if currentValue == 7 || currentValue == 8
            {ratingWord.text = "GREAT!"}
        else if currentValue >= 9
            {ratingWord.text = "AMAZING!!!"}
        
    }
    
    //<KEYBOARD FUNCTIONS>###############
    //Called when keyboard is clicked on in order to scroll view to allow textView to be shown
    @objc func keyboardWillShow(notification: NSNotification) {
            
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
           // if keyboard size is not available for some reason, dont do anything
           return
        }
      
      // move the root view up by the distance of keyboard height
      self.view.frame.origin.y = 175 - keyboardSize.height
    }

    @objc func keyboardWillHide(notification: NSNotification) {
      // move back the root view origin to zero
      self.view.frame.origin.y = 75
    }
    
    //Manages Placeholder in usrReviewTextView
    func textViewDidBeginEditing(_ textView: UITextView) {
        if usrReviewTextView.textColor == UIColor.lightGray {
            usrReviewTextView.text = nil
            usrReviewTextView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if usrReviewTextView.text.isEmpty {
            usrReviewTextView.text = "WRITE A REVIEW"
            usrReviewTextView.textColor = UIColor.lightGray
        }
    }


    //Closes keyboard when return button is pushed
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            usrReviewTextView.resignFirstResponder()
        }
        return true
    }
    
    //VIEW LOADER #########################
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodName.text = name
        
        foodImage.image = image
        
        //TextView Loader
        usrReviewTextView.delegate = self
        usrReviewTextView.layer.borderColor = UIColor.lightGray.cgColor
        usrReviewTextView.layer.borderWidth = 1
        usrReviewTextView.text = "WRITE A REVIEW"
        usrReviewTextView.textColor = UIColor.lightGray
        usrReviewTextView.layer.cornerRadius = 8
        
        addReview()
        
        submitRateBtn.layer.cornerRadius = 8
        submitRateBtn.layer.shadowOpacity = 0.8
        submitRateBtn.layer.shadowOffset = CGSize(width: 1, height: 1)
        
        
        
        // call the 'keyboardWillShow' function when the view controller receive the notification that a keyboard is going to be shown
        NotificationCenter.default.addObserver(self, selector: #selector(FoodReview.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
      
          // call the 'keyboardWillHide' function when the view controlelr receive notification that keyboard is going to be hidden
        NotificationCenter.default.addObserver(self, selector: #selector(FoodReview.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        

    
    }
    

}
