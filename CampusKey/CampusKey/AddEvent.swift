//
//  AddEvent.swift
//  CampusKey
//
//  Created by Anthony Lopez on 2/24/21.
//

import UIKit
import FirebaseDatabase

class AddEvent: UIViewController, UITextFieldDelegate, UITextViewDelegate   {

    
    @IBOutlet weak var eventTitle: UITextField!
    @IBOutlet weak var eventTextView: UITextView!
    @IBOutlet weak var eventDatePicker: UIDatePicker!
    @IBOutlet weak var eventSubmitBtn: UIButton!
    


    var image = UIImage()
    var name = ""
    var date = ""
    var dateSelected = ""
    var timeSelected = ""
    
    var refEvent: DatabaseReference!

    //saves datePicker info when changed. If picker is not touched, "date" will be empty string
    @IBAction func datePicked(_ sender: UIDatePicker) {
        
        let formatter = DateFormatter()

        formatter.dateFormat = "MM-dd-yyyy HH:mm"
        date = formatter.string(from: sender.date)
        dateSelected = String(date.prefix(10))
        timeSelected = String(date.suffix(5))
    }
    
    
    //Should return to previous view with usr's updated review
    @IBAction func eventSubmitBtn(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
        refEvent = Database.database().reference().child("Events/\(dateSelected)/");
        
        let eventInfo = ["Description": eventTextView.text!, "Time": timeSelected, "Title": eventTitle.text!]

        refEvent.childByAutoId().setValue(eventInfo)

        
        let childautoID = refEvent.key
        print(childautoID ?? "its broken")
                
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
            eventTextView.text = "WRITE ABOUT THE EVENT(MAX 250 Characters)"
            eventTextView.textColor = UIColor.lightGray
        }
    }
    //Restricts Add Event Title length
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return range.location < 15
    }
    

    //Closes keyboard when return button is pushed on textField
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return eventTitle.resignFirstResponder()
    }
    
    //Closes keyboard when return button is pushed on textView & Restricts Add Event Description Text Length
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            eventTextView.resignFirstResponder()
        }
        return range.location < 250
    }
    
    
    
    //VIEW LOADER #########################
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventTitle.delegate = self
        
        //TextView Loader
        eventTextView.delegate = self
        eventTextView.layer.borderColor = UIColor.lightGray.cgColor
        eventTextView.layer.borderWidth = 1
        eventTextView.text = "WRITE ABOUT THE EVENT(MAX 250 Characters)"
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
