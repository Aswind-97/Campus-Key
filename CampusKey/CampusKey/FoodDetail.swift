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

    @objc public func addReview(sender: UIBarButtonItem) {
        //Creates a viewController to use data from FoodDetail view
        let vc = storyboard?.instantiateViewController(identifier: "FoodReview") as? FoodReview
    
        //Allows for use of a navigation controller from List to Detail
        self.navigationController?.pushViewController(vc!, animated: true)
        
        //allows for trasnferring data to next view
        vc?.image = foodImage.image!
        vc?.name = foodName.text!
        
        //performSegue(withIdentifier: "Food Review", sender: vc!)

        
      }
     
     
     override func viewDidLoad() {
         super.viewDidLoad()

         //Gets images and names from previous view
         foodName.text = name
         foodImage.image = image
         foodRating.text = rating
        
        //Set up navigation bar item--add review btn
        let btn1 = UIBarButtonItem(image: .add, style: .plain, target: self, action: #selector(addReview))
        self.navigationItem.rightBarButtonItem  = btn1

     
     }
     

}
