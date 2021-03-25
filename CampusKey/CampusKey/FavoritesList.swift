//
//  FavoritesList.swift
//  CampusKey
//
//  Created by Anthony Lopez on 3/14/21.
//

import UIKit
import FirebaseDatabase

class FavoritesList: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    var food = [String]()
    var favFoods = [String]()
    var refFav: DatabaseReference!
    
    
    //Provides height for image and functionality to add an image to the TableView Header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
             
            
        let imageView: UIImageView = UIImageView()
        imageView.image =  UIImage(named: "Favorites Page Logo")!
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
        
    }

    
    
    //Helps to adjust cell height to allow pics to show properly
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    

    //Action for what happens when cell is swiped left at
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { (action, view, completion) in
            let deleted = self.food[indexPath.row]
            self.refFav = Database.database().reference().child("favorites/admin");
            self.refFav.observeSingleEvent(of: .value, with: { snapshot in
                let allRestaurantsSnap = snapshot.children.allObjects as! [DataSnapshot] //contains all child nodes of food
                for foodSnap in allRestaurantsSnap {
                    let testKey = foodSnap.key
                    let favoriteFoods = foodSnap.value as? String ?? "No food name"
                    
                    print(testKey + favoriteFoods + " FIND ME EASIER")
                    
                    if favoriteFoods != deleted {
                        self.favFoods.append(favoriteFoods)
                    }
                }
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)){
                self.refFav.setValue(self.favFoods)
                self.clear()
                self.refresh()
            }
            print(self.food[indexPath.row] + "\n", action)
            completion(true)
        }
        
        //Configure the look of the swipe
        deleteAction.backgroundColor =  UIColor.systemRed
        deleteAction.image = UIImage(systemName: "delete.left")
        
        
        let config = UISwipeActionsConfiguration(actions: [deleteAction])
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoritesCell", for: indexPath) as? FavoritesCell
        
        cell?.foodName.text = food[indexPath.row]
        cell?.foodImage.image = UIImage(named: food[indexPath.row])
        
        
        return cell!
    }
    
    func clear(){
        favFoods = []
        food = []
    }
    
    func loadFav(){
        self.refFav = Database.database().reference().child("favorites/admin");
        self.refFav.observeSingleEvent(of: .value, with: { snapshot in
            let allRestaurantsSnap = snapshot.children.allObjects as! [DataSnapshot] //contains all child nodes of food
            for foodSnap in allRestaurantsSnap {
                let favoriteFoods = foodSnap.value as? String ?? "No food name"
                self.food.append(favoriteFoods)
            }
        })
    }
    
    func refresh(){
        DispatchQueue.main.async {
            self.loadFav()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            print("refreshed")
            self.tableView.reloadData()
        }
    }
    
    
    
    
    
    override func viewDidLoad() {
        refresh()
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }

 
}
