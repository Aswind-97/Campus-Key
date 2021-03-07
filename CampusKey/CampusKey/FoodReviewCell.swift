//
//  FoodReviewCell.swift
//  CampusKey
//
//  Created by Anthony Lopez on 3/5/21.
//

import UIKit

class FoodReviewCell: UITableViewCell {

    @IBOutlet weak var review: UILabel!
    @IBOutlet weak var rating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
