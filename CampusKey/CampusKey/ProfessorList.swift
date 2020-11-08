//
//  ProfessorList.swift
//  CampusKey
//
//  Created by Anthony Lopez on 11/8/20.
//

import UIKit

class ProfessorList: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    let professors = ["John Doe", "Jane Doe", "Alex Smith"]
    
    
    
    
    
    //Helps to allow pics to show properly
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
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
        
        // Do any additional setup after loading the view.
    }
    

}
