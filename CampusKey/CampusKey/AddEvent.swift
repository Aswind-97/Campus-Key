//
//  AddEvent.swift
//  CampusKey
//
//  Created by Anthony Lopez on 2/24/21.
//

import UIKit

class AddEvent: UIViewController, UITextFieldDelegate, UITextViewDelegate   {

    
    @IBOutlet weak var eventTitle: UITextField!
    @IBOutlet weak var eventTextView: UITextView!
    @IBOutlet weak var eventDatePicker: UIDatePicker!
    @IBOutlet weak var eventSubmitBtn: UIButton!
    


    var image = UIImage()
    var name = ""
    var date = ""

    //saves datePicker info when changed. If picker is not touched, "date" will be empty string
    @IBAction func datePicked(_ sender: UIDatePicker) {
        
        let formatter = DateFormatter()

        formatter.dateFormat = "MM-dd-yyyy HH:mm"
        date = formatter.string(from: sender.date)
    }
    
    
    //Should return to previous view with usr's updated review
    @IBAction func eventSubmitBtn(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
        print(date)//to show date is save in a string from time wheel when submit is clicked on
        
        //add what else happens to user data inputted
    }
    
    
    
    //<KEYBOARD FUNCTIONS>###############

    //Manages Placeholder in usrReviewTextView
    func textViewDidBeginEditing(_ textView: UITextView) {
        if eventTextView.textColor == UIColor.lightGray {
            eventTextView.text = nil
            eventTextView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if eventTextView.text.isEmpty {
            eventTextView.text = "WRITE ABOUT THE EVENT"
            eventTextView.textColor = UIColor.lightGray
        }
    }

    //Closes keyboard when return button is pushed on textField
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return eventTitle.resignFirstResponder()
    }
    
    //Closes keyboard when return button is pushed on textView
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            eventTextView.resignFirstResponder()
        }
        return true
    }
    
    
    
    //VIEW LOADER #########################
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventTitle.delegate = self
        
        //TextView Loader
        eventTextView.delegate = self
        eventTextView.layer.borderColor = UIColor.lightGray.cgColor
        eventTextView.layer.borderWidth = 1
        eventTextView.text = "WRITE ABOUT THE EVENT"
        eventTextView.textColor = UIColor.lightGray
        eventTextView.layer.cornerRadius = 8
        
        //Event btn style
        eventSubmitBtn.layer.cornerRadius = 8
        eventSubmitBtn.layer.shadowOpacity = 0.8
        eventSubmitBtn.layer.shadowOffset = CGSize(width: 1, height: 1)
        
        //Doesnt allow user to choose time/date before the time they are entering the event
        let calendar = Calendar(identifier: .gregorian)
        let comps = DateComponents()
        eventDatePicker.minimumDate = calendar.date(byAdding: comps, to: Date())

    
    }
}
