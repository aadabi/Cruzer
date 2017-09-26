//
//  DriverOnDemandSubmitViewController.swift
//  Slug Ride 2
//
//  Created by Andrew Dato 
//  Copyright © 2017 Andrew Dat0. All rights reserved.
//
import Foundation
import UIKit
import GoogleMaps
import GooglePlaces
import SwiftyJSON
import Alamofire

enum Location {
    case startLocation
    case destinationLocation
    case wptLocation
}

class DriverOnDemandSubmitViewController : UIViewController , GMSMapViewDelegate ,  CLLocationManagerDelegate {
    
    @IBOutlet weak var googleMaps: GMSMapView!
    @IBOutlet weak var startLocation: UITextField!
    @IBOutlet weak var destinationLocation: UITextField!
    @IBOutlet weak var wptLocation: UITextField!
    
    
    @IBOutlet weak var postButton: UIButton!
    
    var locationManager = CLLocationManager()
    var locationSelected = Location.startLocation
    
    var timer = Timer()
    
    
    var curLocation = CLLocation()
    var locationStart = CLLocation()
    var locationEnd = CLLocation()
    var locationWaypoint = CLLocation()
    var isthereaWpt = false;
    
    
    
    //var for markers
    var markerCounter = 0
    
    
    //var for rider who requests
    var riderEmail: String!
    var riderDepLat: Double!
    var riderDepLon: Double!
    var riderDesLat: Double!
    var riderDesLon: Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.postButton.isHidden = true
        
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startMonitoringSignificantLocationChanges()
        
        
        
    
        
        //Your map initiation code
        let camera = GMSCameraPosition.camera(withLatitude: -7.9293122, longitude: 112.5879156, zoom: 15.0)
        
        self.googleMaps.camera = camera
        self.googleMaps.delegate = self
        self.googleMaps?.isMyLocationEnabled = true
        self.googleMaps.settings.myLocationButton = true
        self.googleMaps.settings.compassButton = true
        self.googleMaps.settings.zoomGestures = true
        
    }
    
    
    
    
    //sets the start location as the current location
  
    
    
    
    // MARK: function for create a marker pin on map
    func createMarker(titleMarker: String, iconMarker: UIImage, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(latitude, longitude)
        marker.title = titleMarker
        marker.icon = iconMarker
        marker.map = googleMaps
    }
    
    //MARK: - Location Manager delegates
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error to get location : \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        
        //saves the current location to a global
        self.curLocation = location!
        
        
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 17.0)
        
        
        
        
       
        
        self.googleMaps?.animate(to: camera)
        self.locationManager.stopUpdatingLocation()
        
    }
    
    // MARK: - GMSMapViewDelegate
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        googleMaps.isMyLocationEnabled = true
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        googleMaps.isMyLocationEnabled = true
        
        if (gesture) {
            mapView.selectedMarker = nil
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        googleMaps.isMyLocationEnabled = true
        return false
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("COORDINATE \(coordinate)") // when you tapped coordinate
        
        
        
        
    }
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        googleMaps.isMyLocationEnabled = true
        googleMaps.selectedMarker = nil
        return false
    }
    
    
    
    //MARK: - this is function for create direction path, from start location to desination location
    
    func drawPath(startLocation: CLLocation, endLocation: CLLocation, waypoints: CLLocation)
    {
        let origin = "\(startLocation.coordinate.latitude),\(startLocation.coordinate.longitude)"
        let destination = "\(endLocation.coordinate.latitude),\(endLocation.coordinate.longitude)"
        let wpt = "\(waypoints.coordinate.latitude),\(waypoints.coordinate.longitude)"
        
        //url for waypoints
//        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&waypoints=\(wpt)&mode=driving"
        
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving"
        
        
        
        Alamofire.request(url).responseJSON { response in
            
            print(response.request as Any)  // original URL request
            print(response.response as Any) // HTTP URL response
            print(response.data as Any)     // server data
            print(response.result as Any)   // result of response serialization
            
            let json = JSON(data: response.data!)
            let routes = json["routes"].arrayValue
            let distance = startLocation.distance(from: endLocation)
            print(distance)
            
            
            
            // print route using Polyline
            for route in routes
            {
                let routeOverviewPolyline = route["overview_polyline"].dictionary
                let points = routeOverviewPolyline?["points"]?.stringValue
                let path = GMSPath.init(fromEncodedPath: points!)
                let polyline = GMSPolyline.init(path: path)
                
                polyline.strokeWidth = 4
                polyline.strokeColor = UIColor.purple
                polyline.map = self.googleMaps
                
                //this code sets the camera of Google Maps to view the entire route
                let x: UInt!
                x = 1
                
                var bounds = GMSCoordinateBounds()
                for index in x...(path?.count())!{
                    bounds = bounds.includingCoordinate((path?.coordinate(at: index))!)
                    
                }
                self.googleMaps.animate(with: GMSCameraUpdate.fit(bounds))
            }
            
        }
    }
    
    
    func drawPathWaypt(startLocation: CLLocation, endLocation: CLLocation, waypoints: CLLocation)
    {
        //Uses current location as the first point in route instead of using input location
        //let origin = "\(curLocation.coordinate.latitude),\(curLocation.coordinate.longitude)"
        
        
        //uses input location 
        let origin = "\(startLocation.coordinate.latitude),\(startLocation.coordinate.longitude)"
        let destination = "\(endLocation.coordinate.latitude),\(endLocation.coordinate.longitude)"
        let wpt = "\(waypoints.coordinate.latitude),\(waypoints.coordinate.longitude)"
        
        //url for waypoints
                let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&waypoints=\(wpt)&mode=driving"
        
        
        
        
        
        Alamofire.request(url).responseJSON { response in
            
            print(response.request as Any)  // original URL request
            print(response.response as Any) // HTTP URL response
            print(response.data as Any)     // server data
            print(response.result as Any)   // result of response serialization
            
            let json = JSON(data: response.data!)
            let routes = json["routes"].arrayValue
            
            //let distance = startLocation.distance(from: endLocation)
            //let distance = startLocation.
            
            
            // print route using Polyline
            for route in routes
            {
                let routeOverviewPolyline = route["overview_polyline"].dictionary
                let points = routeOverviewPolyline?["points"]?.stringValue
                let path = GMSPath.init(fromEncodedPath: points!)
                let polyline = GMSPolyline.init(path: path)
                
                polyline.strokeWidth = 4
                polyline.strokeColor = UIColor.red
                polyline.map = self.googleMaps
            }
            
        }
    }
    
    
    
    
    // MARK: when start location tap, this will open the search location
    @IBAction func openStartLocation(_ sender: UIButton) {
        
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self
        
        // selected location
        locationSelected = .startLocation
        
        // Change text color
        UISearchBar.appearance().setTextColor(color: UIColor.black)
        self.locationManager.stopUpdatingLocation()
        
        self.present(autoCompleteController, animated: true, completion: nil)
    }
    
    // MARK: when destination location tap, this will open the search location
    @IBAction func openDestinationLocation(_ sender: UIButton) {
        
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self
        
        // selected location
        locationSelected = .destinationLocation
        
        // Change text color
        UISearchBar.appearance().setTextColor(color: UIColor.black)
        self.locationManager.stopUpdatingLocation()
        
        self.present(autoCompleteController, animated: true, completion: nil)
    }
    
    //waypoints button
//    @IBAction func wptButton(_ sender: UIButton) {
//        isthereaWpt = true
//        let autoCompleteController = GMSAutocompleteViewController()
//        autoCompleteController.delegate = self
//        
//        locationSelected = .wptLocation
//        
//        UISearchBar.appearance().setTextColor(color: UIColor.black)
//        self.locationManager.stopUpdatingLocation()
//        
//        self.present(autoCompleteController, animated: true, completion:nil)
//        
//        
//    }
    
    @IBAction func driverPostRide(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        
        
//        let dict = ["driver_email":appDelegate.user_email,"driver_departure": locationStart,"driver_destination": locationEnd] as [String: Any]
        
        let dict = ["driver_email":appDelegate.user_email,"driver_departure_lat": locationStart.coordinate.latitude ,"driver_departure_lon":locationStart.coordinate.longitude,"driver_destination_lat": locationEnd.coordinate.latitude ,"driver_destination_lon":locationEnd.coordinate.longitude] as [String: Any]
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted){
            
            //SUBJECT TO URL CHANGE!!!!!
            let url = NSURL(string: "http://138.68.252.198:8000/rideshare/driver_ondemand_change/")!
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request as URLRequest){
                data, response, error in
                if let httpResponse = response as? HTTPURLResponse{
                    print(httpResponse.statusCode)
                    if(httpResponse.statusCode == 200){
                        print("HTTP Post is Good")
                        return
                    }
                }
                
                guard error == nil else{
                    print(error!)
                    return
                }
                guard let data = data else{
                    print("data is empty")
                    return
                }
                
            }
            
            //polls for requests at an interval of 20 seconds
            self.timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.pollforRequests(_:)), userInfo: nil, repeats: true)
            
            
            
            
            
            task.resume()
            
            
            
        }

        
        
    }
    
    
//    func test(_ sender: Any){
//        let alert = UIAlertController(title: "Rider Request", message: "Tap Accept to give a ride to andrew@ucsc.edu or Decline to keep checking for Riders ", preferredStyle: UIAlertControllerStyle.alert)
//        alert.addAction(UIAlertAction(title: "Accept", style: UIAlertActionStyle.default, handler: {action in
//            self.drawPathWaypt(startLocation: self.locationStart, endLocation: self.locationEnd, waypoints: self.locationWaypoint)
//        }))
//        alert.addAction(UIAlertAction(title:"Decline",style: UIAlertActionStyle.default, handler:
//            {action in
//                
//                //set timer for polling again because rider was declined
//                //self.timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.pollforRequests(_:)), userInfo: nil, repeats: true)
//        }
//        ))
//        self.present(alert, animated: true, completion: nil)
//    
//    }
    
    
    func pollforRequests(_ sender: Any){
        print("Server Poll Driver Side")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        
        
        //        let dict = ["driver_email":appDelegate.user_email,"driver_departure": locationStart,"driver_destination": locationEnd] as [String: Any]
        
        let dict = ["driver_email":appDelegate.user_email] as [String: Any]
        print(dict)
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted){
            print("Driver Polling Success")
            //SUBJECT TO URL CHANGE!!!!!
            let url = NSURL(string: "http://138.68.252.198:8000/rideshare/driver_ondemand_get_rider/")!
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request as URLRequest){
                data, response, error in
                if let httpResponse = response as? HTTPURLResponse{
                    print(httpResponse.statusCode)
                    if(httpResponse.statusCode != 200){
                        print("Error in Polling for Requests, Driver")
                        return
                    }
                }
                
                guard error == nil else{
                    print(error!)
                    return
                }
                guard let data = data else{
                    print("data is empty")
                    return
                }
                
                //gets request if there is one, along with info in order to get rider coordinates
                let json = try! JSONSerialization.jsonObject(with: data, options: []) as AnyObject
                print("Rider Object Received by Driver: ")
                print(json)
                let users = json as? [[String: Any]]
                
                
                
                for user in users!{
                    if (user["riderod_email"] != nil){
                        
                        self.riderEmail = user["riderod_email"] as! String
                        //print(self.driverEmail)
                    }
                    if (user["rider_departure_lat"] != nil){
                        
                        self.riderDepLat = user["rider_departure_lat"] as! Double
                    }
                    if (user["rider_departure_lon"] != nil){
                        
                        self.riderDepLon = user["rider_departure_lon"] as! Double
                    }
                    if (user["rider_destination_lat"] != nil){
                        
                        self.riderDesLat = user["rider_destination_lat"] as! Double
                       
                    }
                    if (user["rider_destination_lon"] != nil){
                        
                       self.riderDesLon = user["rider_destination_lon"] as! Double
                        
                        print(self.riderDesLon)
                       
                        
                    }
                
                
                }
                
                
                print("RIDER LONGITUDE == ")
                print(self.riderDesLon)
                
                
                //if statement to determine if a rider has been found
                if self.riderDesLon != nil {
                    
                    //stop polling when rider is found
                    //self.timer.invalidate()
                    
                    self.isthereaWpt = true
                    self.locationWaypoint = CLLocation(latitude: self.riderDesLat,longitude: self.riderDesLon)
                    
                    
                    let alert = UIAlertController(title: "Rider Request", message: "Tap Accept to give a ride to \(self.riderEmail) or Decline to keep checking for Riders ", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Accept", style: UIAlertActionStyle.default, handler: {action in
                        self.drawPathWaypt(startLocation: self.locationStart, endLocation: self.locationEnd, waypoints: self.locationWaypoint)
                    }))
                    alert.addAction(UIAlertAction(title:"Decline",style: UIAlertActionStyle.default, handler:
                        {action in
                            
                            //set timer for polling again because rider was declined
                           //self.timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.pollforRequests(_:)), userInfo: nil, repeats: true)
                    }
                    ))
                    self.present(alert, animated: true, completion: nil)
                    
                    
                    
                    
                }
                
                
            }
            task.resume()
            
            
            
        }

    
    }
    
    // MARK: SHOW DIRECTION WITH BUTTON
    @IBAction func showDirection(_ sender: UIButton) {
        self.postButton.isHidden = false
        
        // when button direction tapped, must call drawpath func
        self.drawPath(startLocation: locationStart, endLocation: locationEnd,waypoints: locationWaypoint)
       
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
}

// MARK: - GMS Auto Complete Delegate, for autocomplete search location
extension DriverOnDemandSubmitViewController: GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error \(error)")
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        // Change map location
        let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 16.0
        )
        
        // set coordinate to text
        if locationSelected == .startLocation {
            startLocation.text = "\(place.coordinate.latitude), \(place.coordinate.longitude)"
            locationStart = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
            createMarker(titleMarker: "Location Start", iconMarker: #imageLiteral(resourceName: "mapspin"), latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        } else if locationSelected == .destinationLocation {
            destinationLocation.text = "\(place.coordinate.latitude), \(place.coordinate.longitude)"
            locationEnd = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
            createMarker(titleMarker: "Location End", iconMarker: #imageLiteral(resourceName: "mapspin"), latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        } else if locationSelected == .wptLocation{
            wptLocation.text = "\(place.coordinate.latitude), \(place.coordinate.longitude)"
            locationWaypoint = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
            createMarker(titleMarker: "Waypoint", iconMarker: #imageLiteral(resourceName: "mapspin"), latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        }
        
        
        self.googleMaps.camera = camera
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}

public extension UISearchBar {
    
    public func setTextColor00(color: UIColor) {
        let svs = subviews.flatMap { $0.subviews }
        guard let tf = (svs.filter { $0 is UITextField }).first as? UITextField else { return }
        tf.textColor = color
    }
    
}


