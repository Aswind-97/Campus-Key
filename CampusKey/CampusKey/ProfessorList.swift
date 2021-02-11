//
//  ProfessorList.swift
//  CampusKey
//
//  Created by Anthony Lopez on 11/8/20.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class ProfessorList: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var professors = [String]()
    var ratings = [String]()
    
    var refProfs: DatabaseReference!
    
    
//    let professors = ["John Doe", "Jane Doe", "Alex Smith", "Eliza Holmes", "Jack Nichols", "Chuck Finley", "Sarah Marshall", "Louis Stern", "Karina Wo", "Amanda Taylor"]
//    let ratings = ["9.5", "9.8", "8.2", "10", "4.3", "7.4", "9.1", "6.9", "9.6", "5.6"]
    
    func readAllProfs() {
        
        refProfs = Database.database().reference().child("professors/people");
        
        refProfs.observeSingleEvent(of: .value, with: { snapshot in
            let allFacultySnap = snapshot.children.allObjects as! [DataSnapshot] //contains all child nodes of food
            for profSnap in allFacultySnap { //iterate over each restaurant node
                let profID = profSnap.key //arborGrill, burgerKing etc
                let profName = profSnap.childSnapshot(forPath: "display_name").value as? String ?? "No food name"
                //let ratingAvg = profSnap.childSnapshot(forPath: "ratingAvg").value as? Int ?? 0
                
                print(profID)
                print(profName)
                
                //let stringAvg = String(ratingAvg)
                
                //self.ratings.append(stringAvg)
                //self.food.append(foodName)
            }
            
            //print(self.ratings)
            // print(self.food)
        })
    }
    
    
    //Helps to allow pics to show properly
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    //Action for what happens when cell is clicked on
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Creates a viewController to use data from ProfessorDetail view
        let vc = storyboard?.instantiateViewController(identifier: "ProfessorDetail") as? ProfessorDetail
    
        //Allows for use of a navigation controller from List to Detail
        self.navigationController?.pushViewController(vc!, animated: true)
        
        //allows for trasnferring data to next view
        vc?.image = UIImage(named: professors[indexPath.row])!
        vc?.name = professors[indexPath.row]
        vc?.rating = ratings[indexPath.row]
    
    }
    
    //Determines how many cells appear
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return professors.count
    }
    
    //Fills cells with proper data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ProfessorCell
        
        cell?.professorName.text = professors[indexPath.row]
        cell?.professorImage.image = UIImage(named: professors[indexPath.row])
        
        
        return cell!
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        readAllProfs()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    

}
