//
//  FoodList.swift
//  CampusKey
//
//  Created by Anthony Lopez on 11/17/20.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class FoodList: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var ref: DatabaseReference! = Database.database().reference()

//    refHandle = postRef.observe(DataEventType.value, with: { (snapshot) in
//      let postDict = snapshot.value as? [String : AnyObject] ?? [:]
//      // ...
//    })
    
    var i = 0
    
    var food = [String]()
    var ratings = [String]()
    
    var refFoods: DatabaseReference!
    
    
    // let ref = self.ref.child("foods") //self.ref points to MY firebase.
    func readAllFoods() {
        
        refFoods = Database.database().reference().child("food");
        
        refFoods.observeSingleEvent(of: .value, with: { snapshot in
            let allRestaurantsSnap = snapshot.children.allObjects as! [DataSnapshot] //contains all child nodes of food
            for foodSnap in allRestaurantsSnap { //iterate over each restaurant node
                let restaurantName = foodSnap.key //arborGrill, burgerKing etc
                let foodName = foodSnap.childSnapshot(forPath: "foodName").value as? String ?? "No food name"
                let ratingAvg = foodSnap.childSnapshot(forPath: "ratingAvg").value as? Int ?? 0
                
                print(foodName)
                print(restaurantName)
                
                let stringAvg = String(ratingAvg)
                
                self.ratings.append(stringAvg)
                self.food.append(foodName)
            }
            
            print(self.ratings)
            print(self.food)
        })
    }
    
    
    
    //Helps to allow pics to show properly
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    //Action for what happens when cell is clicked on
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Creates a viewController to use data from FoodDetail view
        let vc = storyboard?.instantiateViewController(identifier: "FoodDetail") as? FoodDetail
    
        //Allows for use of a navigation controller from List to Detail
        self.navigationController?.pushViewController(vc!, animated: true)
        
        //allows for trasnferring data to next view
        vc?.image = UIImage(named: food[indexPath.row])!
        vc?.name = food[indexPath.row]
        vc?.rating = ratings[indexPath.row]
    }


    
    //Determines how many cells appear
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return food.count
    }
    
    //Fills cells with proper data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath) as? FoodCell
        
        cell?.foodName.text = food[indexPath.row]
        cell?.foodImage.image = UIImage(named: food[indexPath.row])
        
        
        return cell!
    }
    
    
//    var refFoods: DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        readAllFoods()

        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
        
//        refFoods = Database.database().reference().child("food");
//
//        // let ref = self.ref.child("foods") //self.ref points to MY firebase.
//            refFoods.observeSingleEvent(of: .value, with: { snapshot in
//                let allRestaurantsSnap = snapshot.children.allObjects as! [DataSnapshot] //contains all child nodes of food
//                for foodSnap in allRestaurantsSnap { //iterate over each restaurant node
//                    let restaurantName = foodSnap.key //arborGrill, burgerKing etc
//                    let foodName = foodSnap.childSnapshot(forPath: "foodName").value as? String ?? "No food name"
//                    let ratingAvg = foodSnap.childSnapshot(forPath: "ratingAvg").value as? Int ?? 0
//
//                    print(foodName)
//                    print(restaurantName)
//
//                    let stringAvg = String(ratingAvg)
//
//                    self.ratings.append(stringAvg)
//                    self.food.append(foodName)
//                }
//
//                print(self.ratings)
//                print(self.food)
//            })
    }
    

}
