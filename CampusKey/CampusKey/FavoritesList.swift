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
    
    //The bottom was added for testing purposes
    var food = ["Arbor Grill", "Burger King", "Campus Cuisine To Go", "El Pollo Loco", "Freudian Sip", "Geronimos", "Juice It Up!", "Panda Express", "Sierra Marketplace", "The Mercado", "The Orange Grove Bistro", "The Pub Sports Grill"]
   
    //^Added for testing purposes
    
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

    
    
    //Helps to allow pics to show properly
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    

    //Action for what happens when cell is swiped left at
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { (action, view, completion) in
            print(self.food[indexPath.row] + "\n", action)
            //Add what else happens when delete is clicked on
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
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
    }

 
}
