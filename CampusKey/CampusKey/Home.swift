//
//  Home.swift
//  CampusKey
//
//  Created by Anthony Lopez on 11/18/20.
//

import UIKit
import FirebaseDatabase

class Home: UIViewController {

    var refDeals: DatabaseReference!
    var deal:String = ""
    var fav = "Arbor Grill"
    var usrAccess = "yes"
    
    @IBOutlet weak var locationsBtn: UIButton!
    @IBOutlet weak var professorBtn: UIButton!
    @IBOutlet weak var eventsBtn: UIButton!
    @IBOutlet weak var faqsBtn: UIButton!
    @IBOutlet var myButtons: [UIButton]!
    
    func getDeal(){
        refDeals = Database.database().reference().child("deals/\(fav)");
        refDeals.observeSingleEvent(of: .value, with: { snapshot in
            let allDealsSnap = snapshot.children.allObjects as! [DataSnapshot] //contains all child nodes of food
            for dealSnap in allDealsSnap {
                let testKey = dealSnap.key
                let foodDeal = dealSnap.value as? String ?? "this broke"
                print(foodDeal)
                self.deal = foodDeal
            }
        })
    }
    
    func pushNoti(){
        let dealsAlert = UIAlertController(title: "Your deals are here!", message: "\(deal)", preferredStyle: .alert)
        dealsAlert.addAction(UIAlertAction(title: NSLocalizedString("Thanks", comment: "Default action"), style: .default, handler: { _ in
        NSLog("The \"OK\" alert occured.")
        }))
        self.present(dealsAlert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is EventsControl
        {
            let vc = segue.destination as? EventsControl
            vc?.usrAccess = usrAccess
        }
        if segue.destination is LocationsControl
        {
            let vc = segue.destination as? LocationsControl
            vc?.usrAccess = usrAccess
        }
        if segue.destination is ProfessorList
        {
            let vc = segue.destination as? ProfessorList
            vc?.usrAccess = usrAccess
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.getDeal()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
            self.pushNoti()
        }
        
        for button in self.myButtons{
            button.layer.cornerRadius = 8
            button.layer.shadowOpacity = 0.8
            button.layer.shadowOffset = CGSize(width: 1, height: 1)
            button.layer.opacity = (0.95)
            button.titleLabel?.font = UIFont(name: "Copperplate", size: 30)
        }
        
        
        
    }
    
    


}
