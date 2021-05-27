//
//  FAQS.swift
//  CampusKey
//
//  Created by Anthony Lopez on 2/4/21.
//

import UIKit

class FAQS: UIViewController, UITableViewDelegate, UITableViewDataSource {
        
  
    @IBOutlet weak var tableView: UITableView!
    
//START FAQS TEXT
    let arrayOfQuestions = ["Q: How do I reset my password?",
                            
                            "Q: I am a CSUN Student, but am unable to create a student account, why is that?",
                            
                            "Q: I saw a review that was inappropriate. What do I do?",
                            
                            "Q: How do I delete my own reviews?",
                            
                            "Q: How do I sign back in as a student?",
                            
                            "Q: Why can’t I write my own reviews?",
                            
                            "Q: How do I add a suggestion of a location/person that needs to be added?",
                            
                            "Q: How long does a suspension last for suspended accounts?",
                            
                            "Q: Is this application only available on CSUN’s campus?",
                            
                            "Support Team:",
                            
                            "CSUN Admissions & Records:"
    
    ]
    let arrayOfFaqs = [
                        "A: Under the profile tab of your account, select “change passcode”. A link will be sent to the email associated with your account to change your password.",

                        "A: If you’re an incoming freshman or transfer student, your CSUN ID may not yet be in the database. Please contact CSUN’s ‘Admissions & Records’ for more info on the matter (INFO BELLOW) and please sign in under a guest account for the time being!",

                        "A: You can report the review that flags it for us as something that we need to review. Thank you in advance for bringing it to our attention!",

                        "A: Reviews are meant to be statements that you feel strongly about. If you truly changed your mind about it, please reach out to our support team about what review you’d like to change with the title and reasoning as to why!",

                        "A: Under the profile tab, log out of the guest account. Then either register under a student account or sign in under your current student account.",

                        "A: Credibility is a major factor in what we provide at Campus Key. Unfortunately, if you are signed in under a guest account, we cannot allow you to provide your review as there’s no real way of checking if you were there. We thank you for understanding and are glad that you are eager to provide some feedback!",

                        "A: Please reach out to our support team if you have a request for a new addition of a location or faculty member that needs to be added!",

                        "A: Based upon the severity of the incident, suspensions range anywhere from a week to an entire semester.",


                        "A: Currently yes; our home/CSUN’s campus is the guinea pig for us at ‘Campus Key’!",
        
                        "Email: campusKey@gmail.com",
        
                        "https://www.csun.edu/current-students/contact-page"
    ]
    

    
//END FAQS TEXT
    
    //Provides height for image and functionality to add an image to the TableView Header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
             
            
        let imageView: UIImageView = UIImageView()
        imageView.image =  UIImage(named: "Faqs Page Logo")!
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
        
    }

    
    //Number of cells in table view to appear
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfQuestions.count
    }
    
    //How to populate cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "faqsCell", for: indexPath) as? FAQSCell
        
        cell?.questionLabel.text = arrayOfQuestions[indexPath.row]
        cell?.faqsLabel.text = arrayOfFaqs[indexPath.row]
                
        return cell!
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        

    }
    
}
