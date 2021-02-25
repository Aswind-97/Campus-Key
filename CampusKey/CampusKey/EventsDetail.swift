//
//  EventsDetail.swift
//  CampusKey
//
//  Created by Anthony Lopez on 2/23/21.
//

import UIKit

class EventsDetail: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventInfo: UILabel!
    
    var image = UIImage()
    var name = ""
    var identifier = ""
    var time = ""
    var info = ""


     
     override func viewDidLoad() {
         super.viewDidLoad()

         //Gets images and names from previous view
         eventName.text = name
         eventImage.image = image
         eventInfo.text = info
        

     
     }
     

}
