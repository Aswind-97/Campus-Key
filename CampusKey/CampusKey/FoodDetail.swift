//
//  FoodDetail.swift
//  CampusKey
//
//  Created by Anthony Lopez on 11/17/20.
//

import UIKit

class FoodDetail: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var foodName: UILabel!
    
    @IBOutlet weak var foodImage: UIImageView!
    
    @IBOutlet weak var foodInfo: UILabel!
    
    @IBOutlet weak var foodRating: UILabel!
    
    
    
    var image = UIImage()
     var name = ""
     var rating = ""
     
     
     
     override func viewDidLoad() {
         super.viewDidLoad()

         //Gets images and names from previous view
         foodName.text = name
         foodImage.image = image
         foodRating.text = rating
         
         
         // Do any additional setup after loading the view.
     }
     

}
