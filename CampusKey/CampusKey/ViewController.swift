//
//  ViewController.swift
//  CampusKey
//
//  Created by Anthony Lopez on 10/22/20.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UITextFieldDelegate {

    let locationManager = CLLocationManager()
    
    @IBOutlet weak var emailHolder: UITextField!
    
    @IBOutlet weak var passwordHolder: UITextField!
    
    @IBAction func signInButton(_ sender: Any) {
    }
    
    @IBAction func forgotPasswordButton(_ sender: Any) {
    }
    
    @IBAction func registerButton(_ sender: Any) {
    }
    
    let db = DBHelper()
    
    //Closes keyboard when return button is pushed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == emailHolder
            {return emailHolder.resignFirstResponder()}
        else if textField == passwordHolder
            {return passwordHolder.resignFirstResponder()}
        
        return true
        
    }
    
    
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            //getCurrentLocation()
            self.emailHolder.delegate = self
            self.passwordHolder.delegate = self
        }
        
        func getCurrentLocation() {
            // Ask for Authorisation from the User.
            self.locationManager.requestAlwaysAuthorization()

            // For use in foreground
            self.locationManager.requestWhenInUseAuthorization()

            if CLLocationManager.locationServicesEnabled() {
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                locationManager.startUpdatingLocation()
            }
        }

    }

    extension ViewController: CLLocationManagerDelegate {
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
               guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
               print("locations = \(locValue.latitude) \(locValue.longitude)")
            //lblLocation.text = "latitude = \(locValue.latitude), longitude = \(locValue.longitude)"
        }

}
