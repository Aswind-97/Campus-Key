//
//  EventsControl.swift
//  CampusKey
//
//  Created by Anthony Lopez on 2/10/21.
//

import FSCalendar
import UIKit
import FirebaseDatabase

class EventsControl: UIViewController, FSCalendarDelegate, UITableViewDelegate, UITableViewDataSource {
  
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var tableView: UITableView!
    
    var events = [String]()
    var eventTime = [String]()
    var eventDesc = [String]()
    var eventIden = [String]()
    //let events = ["John Doe", "Jane Doe", "Alex Smith", "Eliza Holmes", "Jack Nichols", "Chuck Finley", "Sarah Marshall", "Louis Stern", "Karina Wo", "Amanda Taylor"]
    var dateSelected = "MM-dd-YYYY"
    
    var refEvent: DatabaseReference!

    
    //Action for what happens when a date is selected
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "MM-dd-YYYY"
        self.dateSelected = formatter.string(from: date)
        print("This is the date: \(dateSelected)")
        events = [String]()
        eventTime = [String]()
        eventDesc = [String]()
        eventIden = [String]()
        refresh()
    }
    func readAllEvents(){
        refEvent = Database.database().reference().child("Events/\(dateSelected)/");
        
        refEvent.observeSingleEvent(of: .value, with: { snapshot in
            let allEventSnap = snapshot.children.allObjects as! [DataSnapshot] //contains all child nodes of food
            for eventSnap in allEventSnap { //iterate over each restaurant node
                let eventKey = eventSnap.key //uniqueId random gen
                
                let eventTitle = eventSnap.childSnapshot(forPath: "Title").value as? String ?? "No event title"
                let eventTime = eventSnap.childSnapshot(forPath: "Time").value as? String ?? "no time"
                let eventDes = eventSnap.childSnapshot(forPath: "Description").value as? String ?? "no info entered"
                //let stringAvg = String(ratingAvg)
                    
                self.events.append(eventTitle)
                self.eventTime.append(eventTime)
                self.eventDesc.append(eventDes)
                self.eventIden.append(eventKey)

            }
            
            print(self.events)
            //print(self.e)
        })
    }
    func refresh(){
        DispatchQueue.main.async {
            self.readAllEvents()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            print("refreshed")
            self.tableView.reloadData()
        }
    }
    func delay(interval: TimeInterval, closure: @escaping () -> Void) {
         DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
              closure()
         }
    }

    
    @objc public func addEvent(sender: UIBarButtonItem) {
        //Creates a viewController to use data from FoodDetail view
        let vc = storyboard?.instantiateViewController(identifier: "AddEvent") as? AddEvent

    
        //Allows for use of a navigation controller from List to Detail
        self.navigationController?.pushViewController(vc!, animated: true)
        
      }

    //Helps to allow pics to show properly by adjusting height of rows
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    //Action for what happens when cell is clicked on
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Creates a viewController to use data from ProfessorDetail view
        let vc = storyboard?.instantiateViewController(identifier: "EventsDetail") as? EventsDetail
    
        //Allows for use of a navigation controller from List to Detail
        self.navigationController?.pushViewController(vc!, animated: true)
        
        //allows for trasnferring data to next view
        vc?.image = UIImage(named: events[indexPath.row]) ?? UIImage(named: "Burger King")!
        vc?.identifier = eventIden[indexPath.row]
        vc?.name = events[indexPath.row]
        vc?.info = eventDesc[indexPath.row]
        vc?.time = eventTime[indexPath.row]
        
    
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //Determines how many cells appear
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    //Fills cells with proper data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? EventsCell
        
        cell?.eventName.text = events[indexPath.row]
        cell?.eventImage.image = UIImage(named: events[indexPath.row]) ?? UIImage(named: "Burger King")!
                
        return cell!
    }
    
    
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        calendar.delegate = self
        
        self.title = "Events Calendar"
        
        //Set up navigation bar item--add review btn
        let btn1 = UIBarButtonItem(image: .add, style: .plain, target: self, action: #selector(addEvent))
        self.navigationItem.rightBarButtonItem  = btn1

    }
    
    
}
