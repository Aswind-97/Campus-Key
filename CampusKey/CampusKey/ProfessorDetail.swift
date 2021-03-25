//
//  ProfessorDetail.swift
//  CampusKey
//
//  Created by Anthony Lopez on 11/8/20.
//

import UIKit

class ProfessorDetail: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var professorName: UILabel!
    @IBOutlet weak var professorImage: UIImageView!
    @IBOutlet weak var ProfessorInfo: UILabel!
    @IBOutlet weak var professorRating: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var usrAccess = ""
    var image = UIImage()
    var name = ""
    var rating = ""
    
    let reviews = ["I love to eat here but it gives me the shits dejidje iji jfei jife jfiejfi ejfi ej fijei fj ifjierfjiej iojwoi jweioj fioewfj ewiojfeqoiwfoew jfoiwe fiefoiwfew wofwejfoef enfdeqjdnhwfdwh here here here", "OK", "I do not like eating here since they always get my order wrong", "Eliza Holmes is always kind to me here", "I enjoy eating here once a week", "Chuck Finley, the manager, loves to stare at me, weirdo!"]
    let ratings = ["7", "4", "2", "8", "9", "3"]
    
    //Provides functionality in the TableView Header

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            
        let header: UILabel = UILabel()
        header.text = "Reviews"
        header.font = UIFont(name: "Copperplate", size: 25)
        header.textAlignment = NSTextAlignment.center
        header.backgroundColor = UIColor.systemRed
        header.textColor = UIColor.white
        
        return header
    }

    //Number of cells in table view to appear
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    //How to populate cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "professorReviewCell", for: indexPath) as? ProfessorReviewCell
        
        cell?.review.text = reviews[indexPath.row]
        cell?.rating.text = ratings[indexPath.row]
                
        return cell!
    }
    
    //creates spacing/height of cells
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    @objc public func addReview(sender: UIBarButtonItem) {
        //Creates a viewController to use data from FoodDetail view
        let vc = storyboard?.instantiateViewController(identifier: "ProfessorReview") as? ProfessorReview
    
        //Allows for use of a navigation controller from List to Detail
        self.navigationController?.pushViewController(vc!, animated: true)
        
        //allows for trasnferring data to next view
        vc?.image = professorImage.image!
        vc?.name = professorName.text!
        
      }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Gets images and names from previous view
        professorName.text = name
        professorImage.image = image
        professorRating.text = rating
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.borderWidth = 0.5

        //Set up navigation bar item--add review btn
        if usrAccess == "yes"{
            let btn1 = UIBarButtonItem(image: .add, style: .plain, target: self, action: #selector(addReview))
            self.navigationItem.rightBarButtonItem  = btn1
        }
    }
    

    

}
