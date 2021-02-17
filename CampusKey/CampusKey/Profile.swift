//
//  Profile.swift
//  CampusKey
//
//  Created by Anthony Lopez on 11/17/20.
//

import UIKit

class Profile: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var usrName: UILabel!
    @IBOutlet weak var usrEmail: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var signOutBtn: UIButton!
    var imagePicker = UIImagePickerController()

    
    @IBAction func signOutBtn(_ sender: Any) {
    }
    
    //Allows usr to choose pic from gallery to have as profile pic when btn is clicked
    @IBAction func profilePicBtn(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){

            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false

            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    //Assigns picked photo to profile pic
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismiss(animated: true, completion: { () -> Void in})

        profilePic.image = image
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signOutBtn.layer.cornerRadius = 8
        signOutBtn.layer.shadowOpacity = 0.8
        signOutBtn.layer.shadowOffset = CGSize(width: 1, height: 1)
        
        
        //Add a way to store profile pic with default photo from DB. Then capture usered entered pic if ever stored

    }
    

}
