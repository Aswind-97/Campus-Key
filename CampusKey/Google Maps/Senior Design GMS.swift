//Enable billing account & get API key
//Enable Maps SDK & Places API
//Add your API key to your AppDelegate.swift
import GooglePlaces
import GoogleMaps
GMSPlacesClient.provideAPIKey("YOUR_API_KEY") //Replace with given API key
GMSServices.provideAPIKey("YOUR_API_KEY") //Replace with given API key

//Declare variables for user's location
var locationManager: CLLocationManager!
var currentLocation: CLLocation?
var mapView: GMSMapView!
var placesClient: GMSPlacesClient!
var preciseLocationZoomLevel: Float = 15.0
var approximateLocationZoomLevel: Float = 10.0

// Initialize the location manager.
locationManager = CLLocationManager()
locationManager.desiredAccuracy = kCLLocationAccuracyBest
locationManager.requestWhenInUseAuthorization()
locationManager.distanceFilter = 50
locationManager.startUpdatingLocation()
locationManager.delegate = self

placesClient = GMSPlacesClient.shared()

// An array to hold the list of likely places.
//May end up not using likely places feature.
var likelyPlaces: [GMSPlace] = []
// The currently selected place.
var selectedPlace: GMSPlace?

// Delegates to handle events for the location manager.
extension MapViewController: CLLocationManagerDelegate {

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
      
//ADDING A MAP
//Create a map and add it to the view in viewDidLoad() in the main view controller. 
//The map stays hidden until a location update is received
// A default location to use (CSUN).
let defaultLocation = CLLocation(latitude: 34.244572, longitude: -118.528839)

// Create a map.
let zoomLevel = locationManager.accuracyAuthorization == .fullAccuracy ? preciseLocationZoomLevel : approximateLocationZoomLevel
let camera = GMSCameraPosition.camera(withLatitude: defaultLocation.coordinate.latitude,
                                      longitude: defaultLocation.coordinate.longitude,
                                      zoom: zoomLevel)
mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
mapView.settings.myLocationButton = true
mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
mapView.isMyLocationEnabled = true

// Add the map to the view, hide it until we've got a location update.
view.addSubview(mapView)
mapView.isHidden = true

//PROMPTING THE USER TO SELECT THEIR CURRENT PLACE (Likely places if location services enabled).
//Get a list of likely places to populate a UITableView, from which the user can select the place where they are currently located.
// Populate the array with the list of likely places.
func listLikelyPlaces() {
  // Clean up from previous sessions.
  likelyPlaces.removeAll()

  let placeFields: GMSPlaceField = [.name, .coordinate]
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
//Open a new view to present likely places to the user.
// Prepare the segue.
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
  if segue.identifier == "segueToSelect" {
    if let nextViewController = segue.destination as? PlacesViewController {
      nextViewController.likelyPlaces = likelyPlaces
    }
  }
}
//In PlacesViewController, fill the table using the list of most likely places, using the UITableViewDataSource delegate extension.
// Populate the table with the list of most likely places.
extension PlacesViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return likelyPlaces.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
    let collectionItem = likelyPlaces[indexPath.row]

    cell.textLabel?.text = collectionItem.name

    return cell
  }
}
//Handle the user's selection using the UITableViewDelegate delegate extension.
class PlacesViewController: UIViewController {

  // ...

  // Pass the selected place to the new view controller.
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "unwindToMain" {
      if let nextViewController = segue.destination as? MapViewController {
        nextViewController.selectedPlace = selectedPlace
      }
    }
  }
}

// Respond when a user selects a place.
extension PlacesViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    selectedPlace = likelyPlaces[indexPath.row]
    performSegue(withIdentifier: "unwindToMain", sender: self)
  }

  // Adjust cell height to only show the first five items in the table
  // (scrolling is disabled in IB).
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return self.tableView.frame.size.height/5
  }

  // Make table rows display at proper height if there are less than 5 items.
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    if (section == tableView.numberOfSections - 1) {
      return 1
    }
    return 0
  }
}
      

//ADDING A MARKER TO THE MAP (if wanted)
// Update the map once the user has made their selection.
@IBAction func unwindToMain(segue: UIStoryboardSegue) {
  // Clear the map.
  mapView.clear()

  // Add a marker to the map.
  if let place = selectedPlace {
    let marker = GMSMarker(position: place.coordinate)
    marker.title = selectedPlace?.name
    marker.snippet = selectedPlace?.formattedAddress
    marker.map = mapView
  }

  listLikelyPlaces()
}
