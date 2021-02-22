//
//  EventsControl.swift
//  CampusKey
//
//  Created by Anthony Lopez on 2/10/21.
//

import FSCalendar
import UIKit

class EventsControl: UIViewController, FSCalendarDelegate, UITableViewDelegate, UITableViewDataSource {
  
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var tableView: UITableView!
    
    let events = ["John Doe", "Jane Doe", "Alex Smith", "Eliza Holmes", "Jack Nichols", "Chuck Finley", "Sarah Marshall", "Louis Stern", "Karina Wo", "Amanda Taylor"]

    
    //Action for what happens when a date is selected
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "MM-dd-YYYY"
        let date = formatter.string(from: date)
        print("This is the date: \(date)")
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
        vc?.image = UIImage(named: events[indexPath.row])!
        vc?.name = events[indexPath.row]
    
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
        cell?.eventImage.image = UIImage(named: events[indexPath.row])
                
        return cell!
    }
    
    
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        calendar.delegate = self
        
        self.title = "Events Calendar"

    }
    
    
}
