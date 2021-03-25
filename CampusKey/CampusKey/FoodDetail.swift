//
//  FoodDetail.swift
//  CampusKey
//
//  Created by Anthony Lopez on 11/17/20.
//

import UIKit
import FirebaseDatabase

class FoodDetail: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource  {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var foodInfo: UILabel!
    @IBOutlet weak var foodRating: UILabel!
    
    var usrAccess = ""
    var image = UIImage()
    var name = ""
    var rating = ""
    var foodIdent = ""
    var user = ""
    var avgHolder = Double()
    var takeAvg = [Int]()
    var refFoods: DatabaseReference!

    var reviews = [String]()  //["I love to eat here but it gives me the shits dejidje iji jfei jife jfiejfi ejfi ej fijei fj ifjierfjiej iojwoi jweioj fioewfj ewiojfeqoiwfoew jfoiwe fiefoiwfew wofwejfoef enfdeqjdnhwfdwh here here here", "OK", "I do not like eating here since they always get my order wrong", "Eliza Holmes is always kind to me here", "I enjoy eating here once a week", "Chuck Finley, the manager, loves to stare at me, weirdo!"]
    var ratings = [String]()
    

    func getReviews(){
        refFoods = Database.database().reference().child("food/\(foodIdent)/reviews");
        
        refFoods.observeSingleEvent(of: .value, with: { snapshot in
            let allReviewsSnap = snapshot.children.allObjects as! [DataSnapshot] //contains all child nodes of food
            for review in allReviewsSnap {
                let revRate = review.childSnapshot(forPath: "rating").value as? Int ?? 0
                let stringRevRate = String(revRate)
                let revText = review.childSnapshot(forPath: "review").value as? String ?? ""
                self.takeAvg.append(revRate)
                self.ratings.append(stringRevRate)
                self.reviews.append(revText)
            }//iterate over each restaurant node
            self.avgHolder = self.getAvg(numbers: self.takeAvg)
            self.foodRating.text = String(self.avgHolder)
    })
    }
    
    func refresh(){
        DispatchQueue.main.async {
            self.getReviews()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            print("refreshed")
            self.tableView.reloadData()
        }
    }
    func delay(interval: TimeInterval, closure: @escaping () -> Void) {
         DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
              closure()
         }
    }
    
    func getAvg(numbers: [Int]) -> Double{
        var sum = 0
        for number in numbers {
            sum += number
        }
        var  ave : Double = Double(sum) / Double(numbers.count)
        return ave
    }
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodReviewCell", for: indexPath) as? FoodReviewCell
        
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
        let vc = storyboard?.instantiateViewController(identifier: "FoodReview") as? FoodReview
    
        //Allows for use of a navigation controller from List to Detail
        self.navigationController?.pushViewController(vc!, animated: true)
        
        //allows for trasnferring data to next view
        vc?.image = foodImage.image!
        vc?.foodIdent = foodIdent
        
        
      }
     
     
     override func viewDidLoad() {
        super.viewDidLoad()

        //Gets images and names from previous view
        foodImage.image = image
        foodRating.text = rating
        
        refresh()
        
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
