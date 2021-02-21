//
//  EventsDetail.swift
//  
//
//  Created by Anthony Lopez on 2/21/21.
//

import UIKit

class EventsDetail: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventInfo: UILabel!
    
    var image = UIImage()
    var name = ""


     
     override func viewDidLoad() {
         super.viewDidLoad()

         //Gets images and names from previous view
         eventName.text = name
         eventImage.image = image
        

     
     }
     
}
