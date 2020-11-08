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
    
    var image = UIImage()
    var name = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        professorName.text = name
        professorImage.image = image
        
        // Do any additional setup after loading the view.
    }
    

    

}
