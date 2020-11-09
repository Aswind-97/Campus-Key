//
//  MapVC.swift
//  CampusKey
//
//  Created by Javier Aguayo Jr on 11/5/20.
//
//import UIKit
//import GoogleMaps
//import GooglePlaces
//
//class MapVC: UIViewController {
//
//
//    @IBOutlet weak var mapView: GMSMapView!
//    var currentLocation: CLLocation?
//    var preciseLocationZoomLevel: Float = 15.0
//    var approximateLocationZoomLevel: Float = 10.0
//
//    var locationManager = CLLocationManager()
//    //func locationManager;.desiredAccuracy = kCLLocationAccuracyBest
//    //func locationManager;.requestWhenInUseAuthorization()
//    //locationManager.distanceFilter = 50
//    //locationManager.startUpdatingLocation()
//    //locationManager.delegate = self
//
//    override func viewDidLoad() {
//            super.viewDidLoad()
//
//      mapView.isHidden = true
//        // Do any additional setup after loading the view.
//            // GOOGLE MAPS SDK: COMPASS
//            mapView.settings.compassButton = true
//
//            // GOOGLE MAPS SDK: USER'S LOCATION
//            mapView.isMyLocationEnabled = true
//            mapView.settings.myLocationButton = true
//
//        }
//
//
//
//        /*
//        // MARK: - Navigation
//        // In a storyboard-based application, you will often want to do a little preparation before navigation
//        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            // Get the new view controller using segue.destination.
//            // Pass the selected object to the new view controller.
//        }
//        */
//
//    }
//    extension MapVC: CLLocationManagerDelegate {
//        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//               guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
//               print("locations = \(locValue.latitude) \(locValue.longitude)")
//            //lblLocation.text = "latitude = \(locValue.latitude), longitude = \(locValue.longitude)"
//        }
//
//        func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
//                print(error.localizedDescription)
//            }
//
//            func wasCancelled(_ viewController: GMSAutocompleteViewController) {
//
//            }
//    }
import UIKit
import GoogleMaps
import GooglePlaces

class MapVC: UIViewController {

  var locationManager: CLLocationManager!
  var currentLocation: CLLocation?
  
    
    
    
    @IBOutlet var mapView: GMSMapView!
    var placesClient: GMSPlacesClient!
  var preciseLocationZoomLevel: Float = 15.0
  var approximateLocationZoomLevel: Float = 10.0

  // An array to hold the list of likely places.
  var likelyPlaces: [GMSPlace] = []

  // The currently selected place.
  var selectedPlace: GMSPlace?

  // Update the map once the user has made their selection.
//  @IBAction func unwindToMain(segue: UIStoryboardSegue) {
//    // Clear the map.
//    mapView.clear()
//
//    // Add a marker to the map.
//    if let place = selectedPlace {
//      let marker = GMSMarker(position: place.coordinate)
//      marker.title = selectedPlace?.name
//      marker.snippet = selectedPlace?.formattedAddress
//      marker.map = mapView
//    }
//
//    listLikelyPlaces()
//  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Initialize the location manager.
    locationManager = CLLocationManager()
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
    locationManager.distanceFilter = 50
    locationManager.startUpdatingLocation()
    locationManager.delegate = self

    placesClient = GMSPlacesClient.shared()

    // A default location to use when location permission is not granted.
    let defaultLocation = CLLocation(latitude: 34.240083, longitude: -118.529319)// CSUN
    
    // Create a map.
    let zoomLevel = locationManager.accuracyAuthorization == .fullAccuracy ? preciseLocationZoomLevel : approximateLocationZoomLevel
    let camera = GMSCameraPosition.camera(withLatitude: defaultLocation.coordinate.latitude,
                                          longitude: defaultLocation.coordinate.longitude,
                                          zoom: zoomLevel)
    mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
    mapView.isMyLocationEnabled = true
    mapView.settings.myLocationButton = true
    mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]


    // Add the map to the view, hide it until we've got a location update.
    view.addSubview(mapView)
    mapView.isHidden = true

    listLikelyPlaces()
  }

  // Populate the array with the list of likely places.
  func listLikelyPlaces() {
    // Clean up from previous sessions.
    likelyPlaces.removeAll()

    let placeFields: GMSPlaceField = GMSPlaceField(rawValue: GMSPlaceField.name.rawValue | GMSPlaceField.coordinate.rawValue)
    placesClient.findPlaceLikelihoodsFromCurrentLocation(withPlaceFields: placeFields) { (placeLikelihoods, error) in
      guard error == nil else {
        // TODO: Handle the error.
        print("Current Place error: \(error!.localizedDescription)")
        return
      }

      guard let placeLikelihoods = placeLikelihoods else {
        print("No places found.")
        return
      }
      
      // Get likely places and add to the list.
      for likelihood in placeLikelihoods {
        let place = likelihood.place
        self.likelyPlaces.append(place)
      }
    }
  }

  // Prepare the segue.
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "segueToSelect" {
      if let nextViewController = segue.destination as? PlacesVC {
        nextViewController.likelyPlaces = likelyPlaces
      }
    }
  }
}

// Delegates to handle events for the location manager.
extension MapVC: CLLocationManagerDelegate {

  // Handle incoming location events.
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let location: CLLocation = locations.last!
    print("Location: \(location)")

    let zoomLevel = locationManager.accuracyAuthorization == .fullAccuracy ? preciseLocationZoomLevel : approximateLocationZoomLevel
    let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                          longitude: location.coordinate.longitude,
                                          zoom: zoomLevel)

    if mapView.isHidden {
      mapView.isHidden = false
      mapView.camera = camera
    } else {
      mapView.animate(to: camera)
    }

    listLikelyPlaces()
  }

  // Handle authorization for the location manager.
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    // Check accuracy authorization
    let accuracy = manager.accuracyAuthorization
    switch accuracy {
    case .fullAccuracy:
        print("Location accuracy is precise.")
    case .reducedAccuracy:
        print("Location accuracy is not precise.")
    @unknown default:
      fatalError()
    }
    
    // Handle authorization status
    switch status {
    case .restricted:
      print("Location access was restricted.")
    case .denied:
      print("User denied access to location.")
      // Display the map using the default location.
      mapView.isHidden = false
    case .notDetermined:
      print("Location status not determined.")
    case .authorizedAlways: fallthrough
    case .authorizedWhenInUse:
      print("Location status is OK.")
    @unknown default:
      fatalError()
    }
  }

  // Handle location manager errors.
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    locationManager.stopUpdatingLocation()
    print("Error: \(error)")
  }
}


    
