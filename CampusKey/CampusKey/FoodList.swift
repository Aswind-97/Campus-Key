//
//  FoodList.swift
//  CampusKey
//
//  Created by Anthony Lopez on 11/17/20.
//

import UIKit
import FirebaseDatabase

class FoodList: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var food = [String]()
    var ratings = [String]()
    var foodIdent = [String]()
    var favFoods = [String]()
    
    var refFoods: DatabaseReference!
    
    
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
                
                self.foodIdent.append(restaurantName)
                self.ratings.append(stringAvg)
                self.food.append(foodName)
            }
            
            print(self.ratings)
            print(self.food)
        })
    }
    
    func refresh(){
        DispatchQueue.main.async {
            self.readAllFoods()
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
    func clearFav(){
        self.favFoods = []
    }
    
    
    //Provides height for image and functionality to add an image to the TableView Header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
             
            
        let imageView: UIImageView = UIImageView()
        imageView.image =  UIImage(named: "Food Page Logo")!
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
        
    }

    
    
    //Helps to allow pics to show properly
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
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
        vc?.foodIdent = foodIdent[indexPath.row]
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    //Action for what happens when cell is swiped left at
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let favoriteAction = UIContextualAction(style: .normal, title: "Favorite") { (action, view, completion) in
            self.favFoods.append(self.food[indexPath.row])
            let addFav = self.food[indexPath.row]
            self.refFoods = Database.database().reference().child("favorites/admin");
            self.refFoods.observeSingleEvent(of: .value, with: { snapshot in
                let allRestaurantsSnap = snapshot.children.allObjects as! [DataSnapshot] //contains all child nodes of food
                for foodSnap in allRestaurantsSnap {
                    let favoriteFoods = foodSnap.value as? String ?? "No food name"
                    if addFav != favoriteFoods {
                        self.favFoods.append(favoriteFoods)
                    }
                }
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
                self.refFoods.setValue(self.favFoods)
                self.clearFav()
            }
            //Add what else happens when favorite is clicked on
            completion(true)
        }
        //Configure the look of the swipe
        favoriteAction.backgroundColor =  UIColor.systemYellow
        favoriteAction.image = UIImage(systemName: "star")
        
        
        let config = UISwipeActionsConfiguration(actions: [favoriteAction])
        //Prevents action taking place without usr clicking on the new swipe btn again
        config.performsFirstActionWithFullSwipe = false
        
        return config
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
        
        if(food[indexPath.row] != "The Orange Grove Bistro") {
            cell?.diningLogo.image = UIImage(named: "Outdoor Dining Logo")
        }
        else{
            cell?.diningLogo.image = UIImage(named: "empty")
        }
        
        
        return cell!
    }
    
    
    
    
    
    override func viewDidLoad() {
        
        refresh()
        
        super.viewDidLoad()
               
        tableView.delegate = self
        tableView.dataSource = self
        
        self.title = "FOOD"
        // Do any additional setup after loading the view.
    }
    

}
