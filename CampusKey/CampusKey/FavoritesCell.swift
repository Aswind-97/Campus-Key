//
//  FavoritesCell.swift
//  CampusKey
//
//  Created by Anthony Lopez on 3/14/21.
//

import UIKit

class FavoritesCell: UITableViewCell {

    
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var foodName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        foodImage.layer.borderWidth = 1
        foodImage.layer.masksToBounds = false
        foodImage.layer.borderColor = UIColor.black.cgColor
        foodImage.layer.cornerRadius=foodImage.frame.height/2
        foodImage.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
