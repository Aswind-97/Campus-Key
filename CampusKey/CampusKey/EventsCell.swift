//
//  EventsCell.swift
//  CampusKey
//
//  Created by Anthony Lopez on 2/20/21.
//

import UIKit

class EventsCell: UITableViewCell {

    
    @IBOutlet weak var eventTime: UILabel!
    @IBOutlet weak var eventName: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
    /*
        eventImage.layer.borderWidth = 1
        eventImage.layer.masksToBounds = false
        eventImage.layer.borderColor = UIColor.black.cgColor
        eventImage.layer.cornerRadius=eventImage.frame.height/2
        eventImage.clipsToBounds = true
 */
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


}
