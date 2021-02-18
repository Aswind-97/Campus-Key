//
//  ProfessorDetail.swift
//  CampusKey
//
//  Created by Anthony Lopez on 11/8/20.
//

import UIKit

class ProfessorDetail: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var professorName: UILabel!
    
    @IBOutlet weak var professorImage: UIImageView!
    
    @IBOutlet weak var ProfessorInfo: UILabel!
    
    @IBOutlet weak var professorRating: UILabel!
    
    var image = UIImage()
    var name = ""
    var rating = ""
    
    @objc public func addReview(sender: UIBarButtonItem) {
        //Creates a viewController to use data from FoodDetail view
        let vc = storyboard?.instantiateViewController(identifier: "ProfessorReview") as? ProfessorReview
    
        //Allows for use of a navigation controller from List to Detail
        self.navigationController?.pushViewController(vc!, animated: true)
        
        //allows for trasnferring data to next view
        vc?.image = professorImage.image!
        vc?.name = professorName.text!
        
        //performSegue(withIdentifier: "Food Review", sender: vc!)

        
      }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Gets images and names from previous view
        professorName.text = name
        professorImage.image = image
        professorRating.text = rating
        
        
        //Set up navigation bar item--add review btn
        let btn1 = UIBarButtonItem(image: .add, style: .plain, target: self, action: #selector(addReview))
        self.navigationItem.rightBarButtonItem  = btn1
    }
    

    

}
