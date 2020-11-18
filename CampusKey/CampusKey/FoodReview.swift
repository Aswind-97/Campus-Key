//
//  FoodReview.swift
//  CampusKey
//
//  Created by Anthony Lopez on 11/17/20.
//

import UIKit

class FoodReview: UIViewController {

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var ratingWord: UILabel!
    @IBOutlet weak var submitRateBtn: UIButton!
    
    var image = UIImage()
    var name = ""
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        
        rating.text = "\(currentValue)"
        
        if currentValue <= 4
            {ratingWord.text = "POOR"}
        else if currentValue == 5 || currentValue == 6
            {ratingWord.text = "AVERAGE"}
        else if currentValue == 7 || currentValue == 8
            {ratingWord.text = "GREAT"}
        else if currentValue >= 9
            {ratingWord.text = "AMAZING"}
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodName.text = name
        foodImage.image = image
        
        submitRateBtn.layer.cornerRadius = 4

    
        // Do any additional setup after loading the view.
    }
    

}
