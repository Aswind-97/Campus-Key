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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Gets images and names from previous view
        professorName.text = name
        professorImage.image = image
        professorRating.text = rating
        
        
        // Do any additional setup after loading the view.
    }
    

    

}
