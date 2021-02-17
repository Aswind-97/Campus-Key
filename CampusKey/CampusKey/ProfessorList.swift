//
//  ProfessorList.swift
//  CampusKey
//
//  Created by Anthony Lopez on 11/8/20.
//

import UIKit

class ProfessorList: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    let professors = ["John Doe", "Jane Doe", "Alex Smith", "Eliza Holmes", "Jack Nichols", "Chuck Finley", "Sarah Marshall", "Louis Stern", "Karina Wo", "Amanda Taylor"]

    let ratings = ["9.5", "9.8", "8.2", "10", "4.3", "7.4", "9.1", "6.9", "9.6", "5.6"]
    
    
    //Provides height for image and functionality to add an image to the TableView Header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
             
            
        let imageView: UIImageView = UIImageView()
        imageView.image =  UIImage(named: "Professors Page Logo")!
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
        
    }

    
    //Helps to allow pics to show properly by adjusting height of rows
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
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
    
        tableView.deselectRow(at: indexPath, animated: true)
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

        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.title = "PROFESSORS"
        
    }
    

}
