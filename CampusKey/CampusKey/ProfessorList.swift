//
//  ProfessorList.swift
//  CampusKey
//
//  Created by Anthony Lopez on 11/8/20.
//

import UIKit
import FirebaseDatabase

class ProfessorList: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var usrAccess = ""
    var professors = [String]()
    var ratings = [String]()
    
    var profsImage = [String]()
    var imageData = [UIImage]()
    
    var refProfs: DatabaseReference!
    
    func readAllProfs() {
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        refProfs = Database.database().reference().child("professors/people");
        
        refProfs.observeSingleEvent(of: .value, with: { snapshot in
            let allFacultySnap = snapshot.children.allObjects as! [DataSnapshot] //contains all child nodes of food
            DispatchQueue.main.async {
            for profSnap in allFacultySnap { //iterate over each restaurant node
                let profID = profSnap.key //arborGrill, burgerKing etc
                let profName = profSnap.childSnapshot(forPath: "display_name").value as? String ?? "No food name"
                let profImage = profSnap.childSnapshot(forPath: "profile_image").value as? String ?? "We broke it here"
                
                
                if let url = URL(string: profImage){

                    let task = session.dataTask(with: url, completionHandler: {data, response, error in

                        if let err = error {
                            print("Error: \(err)")
                            return
                        }

                        if let http = response as? HTTPURLResponse {
                            if http.statusCode == 200 {
                                let downloadedImage = UIImage(data: data!)
                                
                                    self.imageData.append(downloadedImage!)
                                    print(profID)
                                
                            }
                        }
                   })
                   task.resume()
                }
                
                self.ratings.append("9")
                self.profsImage.append(profImage)
                self.professors.append(profName)
            }
            }
        })
    }
    func refresh(){
        DispatchQueue.main.async {
            self.readAllProfs()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(7)) {
            print("refreshed")
            self.tableView.reloadData()
        }
    }
    func delay(interval: TimeInterval, closure: @escaping () -> Void) {
         DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
              closure()
         }
    }
    
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
        vc?.usrAccess = usrAccess
    
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
        refresh()
        
        super.viewDidLoad()

        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.title = "PROFESSORS"
        
    }
    

}
