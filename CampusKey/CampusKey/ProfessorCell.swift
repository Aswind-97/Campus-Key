//
//  ProfessorCell.swift
//  CampusKey
//
//  Created by Anthony Lopez on 11/8/20.
//

import UIKit

class ProfessorCell: UITableViewCell {

    
    @IBOutlet weak var professorImage: UIImageView!
    
    @IBOutlet weak var professorName: UILabel!
    
    @IBOutlet weak var professorRole: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        professorImage.layer.borderWidth = 1
        professorImage.layer.masksToBounds = false
        professorImage.layer.borderColor = UIColor.black.cgColor
        professorImage.layer.cornerRadius=professorImage.frame.height/2
        professorImage.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
