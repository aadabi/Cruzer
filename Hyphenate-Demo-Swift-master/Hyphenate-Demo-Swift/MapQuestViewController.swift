//
//  MapQuestViewController.swift
//
//  Created by Andrew Dato on 9/17/17.
//  Copyright © 2017 杜洁鹏. All rights reserved.
//
import Foundation
import UIKit
import Mapbox
import SwiftyJSON
import AVFoundation
import CoreEngine

struct dir {
    let coords: CLLocationCoordinate2D
    let narative: String
}

class MapQuestViewController: UIViewController, MGLMapViewDelegate, UISearchBarDelegate, DEMDrivingEngineDelegate, DEMDrivingEngineDataSource {
    @IBOutlet var mapView : MGLMapView!
    fileprivate var searchController: UISearchController!
    
    @IBOutlet weak var arityScore: UILabel!
    @IBOutlet weak var QRImage: UIImageView!
    @IBOutlet weak var backgroundLabel: UILabel!
    @IBOutlet weak var dirLabel: UILabel!
    var loc = CLLocationCoordinate2D()
    let dest = MGLPointAnnotation()
    var arr = [dir]()
    let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: 320, height: 44))
    @IBOutlet weak var AnnotationLabel: UILabel!
    @IBOutlet weak var PersonImage: UIImageView!
    @IBOutlet weak var ChatButton: UIButton!
    @IBOutlet weak var HideButton: UIButton!
    @IBOutlet weak var tripIndicator: UIActivityIndicatorView!
    
    //////////////////////////////////
    //Load Code
    //////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        print("check")
        self.arityScore.isHidden = true
        self.view.addSubview(navBar)
        self.AnnotationLabel.isHidden = true
        self.PersonImage.isHidden = true
        self.ChatButton.isHidden = true
        self.HideButton.isHidden = true
        self.tripIndicator.isHidden = true
        mapView.delegate = self
        //mapView?.mapType = .normal
        self.dirLabel.isHidden = true
        self.backgroundLabel.isHidden = true
        //mapView?.mapType = .nightMode
        //mapView?.trafficEnabled = true
        mapView?.userTrackingMode = .follow
        //Set up the Naviation Bar
        let backButton = UIBarButtonItem(title: "< Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(MapQuestViewController.backButtonAction(_:)))
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationController?.isNavigationBarHidden = false
        
        let searchButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.search, target: self, action: #selector(MapQuestViewController.searchButtonAction(_:)))
        self.navigationItem.rightBarButtonItem = searchButton
        
        //Arity stuff down here
        // using core engine setup
        setupCoreEngine()
        
        
        // register the view controller as a listener
        //registerDriveEventListener()
        // configure Driving Engine
        //configureDrivingEngine()

        //let sharedEngine = DEMDrivingEngineManager.sharedManager() as! DEMDrivingEngineManager
        //sharedEngine.startEngine()
        
    }
    
    
    
    //////////////////////////////////
    //Search Bar Code
    //////////////////////////////////
    func searchButtonAction(_ button: UIBarButtonItem) {
        if searchController == nil {
            searchController = UISearchController(searchResultsController: nil)
        }
        searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.delegate = self
        present(searchController, animated: true, completion: nil)
    }
    
    //////////////////////////////////
    //Search Bar Code
    //////////////////////////////////
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        //directions()
        let dict2 = ["location":searchBar.text] as [String: Any]
        //let dict = ["user_email":appDelegate.user_email, "first_name":"Test", "last_name":"Test", "user_car":"Test", "car_color":"Test", "car_capacity":5] as [String: Any]
        print(dict2)
        if let jsonData = try? JSONSerialization.data(withJSONObject: dict2, options: .prettyPrinted){
            print("success")
            let url = NSURL(string: "http://www.mapquestapi.com/geocoding/v1/address?key=PZQhkAK5GPYCKyWy6kA8ZSbAhjA5W0of")!
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request as URLRequest){
                data, response, error in
                if let httpResponse = response as? HTTPURLResponse{
                    print(httpResponse.statusCode)
                    if(httpResponse.statusCode != 200){
                        print("error")
                        return
                    }
                }
                print("success1")
                guard error == nil else{
                    print(error!)
                    return
                }
                print("success2")
                guard let data = data else {
                    print("Data Empty")
                    return
                }
                print("success3")
                let json = JSON(data: data)
                if json["info"]["statuscode"] == 0 {
                    let var1 = json["results"][0]["locations"][0]["latLng"]["lat"].double
                    let var2 = json["results"][0]["locations"][0]["latLng"]["lng"].double
                    let check = CLLocationCoordinate2DMake(var1! ,var2!)
                    self.dest.coordinate = check
                    self.dest.title = searchBar.text
                    
                    DispatchQueue.main.async(execute: self.searchDone)
                } else {
                    self.errorMessage(err: "Cannot find location")
                }
                
            }
            task.resume()
        }
    }
    
    
    //////////////////////////////////
    //Error Message Code
    //////////////////////////////////
    func errorMessage(err :String) {
        let alert = UIAlertController(title: "Arity Report", message: err, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title:"Ok",style: UIAlertActionStyle.default, handler:
            {action in
                
                //set timer for polling again because rider was declined
                //self.timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.pollforRequests(_:)), userInfo: nil, repeats: true)
        }
        ))
        self.present(alert, animated: true, completion: nil)
    }
    
    //////////////////////////////////
    //Error Message Code
    //////////////////////////////////
    func errorMessage2(err :String) {
        let alert = UIAlertController(title: "Arity Safe Alert", message: err, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title:"Ok",style: UIAlertActionStyle.default, handler:
            {action in
                
                //set timer for polling again because rider was declined
                //self.timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.pollforRequests(_:)), userInfo: nil, repeats: true)
        }
        ))
        self.present(alert, animated: true, completion: nil)
    }
    
    func searchDone() {
        mapView?.addAnnotation(self.dest)
        mapView?.setCenter(self.dest.coordinate, zoomLevel:10, animated: true)
        
        let searchButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.search, target: self, action: #selector(MapQuestViewController.searchButtonAction(_:)))
        //self.navigationItem.rightBarButtonItem = searchButton
        let backButton = UIBarButtonItem(title: "Start Ride", style: UIBarButtonItemStyle.plain, target: self, action: #selector(MapQuestViewController.directions(_:)))
        self.navigationItem.setRightBarButtonItems([backButton, searchButton], animated: true)
    }
    
    
    var timer = Timer()
    
    func drawRoute() {
        var coordinates = [CLLocationCoordinate2D]()
        //coordinates.append(self.loc)
        for vars in self.arr {
            coordinates.append(vars.coords)
        }
        //coordinates.append(self.dest.coordinate)
        print(coordinates)
        
        let polyline = MGLPolyline(coordinates: &coordinates, count: UInt(coordinates.count))
        mapView?.addAnnotation(polyline)
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.pollforUsers(_:)), userInfo: nil, repeats: false)
        //mapView?.showAnnotations([polyline], animated: true)
        startRide()
    }
    
    
    //////////////////////////////////
    //Direct to destination
    //////////////////////////////////
    func directions(_ button: UIBarButtonItem) {
        self.loc.latitude = (mapView?.userLocation?.coordinate.latitude)!
        self.loc.longitude = (mapView?.userLocation?.coordinate.longitude)!
        print(self.loc)
        
        var locCords = "\(self.loc.latitude),\(self.loc.longitude)"
        var destCords = "\(self.dest.coordinate.latitude),\(self.dest.coordinate.longitude)"
        print(locCords)
        print(destCords)
        let dict2 = ["locations":[locCords, destCords]] as [String: Any]
        //let dict = ["user_email":appDelegate.user_email, "first_name":"Test", "last_name":"Test", "user_car":"Test", "car_color":"Test", "car_capacity":5] as [String: Any]
        print(dict2)
        if let jsonData = try? JSONSerialization.data(withJSONObject: dict2, options: .prettyPrinted){
            print("success")
            let url = NSURL(string: "http://www.mapquestapi.com/directions/v2/route?key=PZQhkAK5GPYCKyWy6kA8ZSbAhjA5W0of")!
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request as URLRequest){
                data, response, error in
                if let httpResponse = response as? HTTPURLResponse{
                    print(httpResponse.statusCode)
                    if(httpResponse.statusCode != 200){
                        print("error")
                        return
                    }
                }
                print("success1")
                guard error == nil else{
                    print(error!)
                    return
                }
                print("success2")
                guard let data = data else {
                    print("Data Empty")
                    return
                }
                print("success3")
                let json = JSON(data: data)
                print(json)
                if json["info"]["statuscode"].int == 0 {
                    
                    let var1 = json["route"]["legs"][0]["maneuvers"].array
                    for vars in var1! {
                        let var2 = vars["startPoint"]["lat"].double
                        let var3 = vars["startPoint"]["lng"].double
                        let check = CLLocationCoordinate2DMake(var2!,var3!)
                        let var4 = vars["narrative"].string
                        self.arr.append(dir(coords: check, narative: var4!))
                        DispatchQueue.main.async(execute: self.drawRoute)
                    }
                    print(self.arr)
                } else {
                    self.errorMessage(err: "Cannot find location")
                }
            }
            task.resume()
        }
        
    }
    
    //////////////////////////////////
    //Starts the ride and sends info to the server
    //////////////////////////////////
    func startRide() {
        //guard let selectedPin = selectedPin else { return }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let dict = ["user_email":appDelegate.user_email,
                    "location_latitude": self.loc.latitude ,
                    "location_longitude":self.loc.longitude,
                    "destination_latitude": self.dest.coordinate.latitude ,
                    "destination_longitude":self.dest.coordinate.longitude,
                    "driver_status":appDelegate.driver_status] as [String: Any]
        print(dict)
        if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted){
            print("success")
            //SUBJECT TO URL CHANGE!!!!!
            let url = NSURL(string: "http://138.68.252.198:8000/rideshare/post_ride/")!
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "POST"
            request.setValue("Token \(appDelegate.token)", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request as URLRequest){
                data, response, error in
                if let httpResponse = response as? HTTPURLResponse{
                    print(httpResponse.statusCode)
                    if(httpResponse.statusCode != 200){
                        print("error")
                        return
                    }
                }
                print("success1")
                guard error == nil else{
                    print(error!)
                    return
                }
                print("success2")
                guard data != nil else{
                    print("data is empty")
                    return
                }
                print("success3")
                //let json = try! JSONSerialization.jsonObject(with: data, options: []) as AnyObject
                //print(json)
                DispatchQueue.main.async(execute: self.postDone)
            }
            task.resume()
        }
    }
    
    var severity : String = ""
    var accType : String = ""
    
    func postDone() {
        navigationItem.titleView = nil
        let appDelegate = UIApplication.shared.delegate as! AppDelegate        
        
        //let backButton2 = UIBarButtonItem(title: "End Ride", style: UIBarButtonItemStyle.plain, target: self, action: #selector(AppleMapsViewController.endRideButtonAction(_:)))
        //self.navigationItem.rightBarButtonItem = backButton2
        
        
        //Arity Danger Code
        let geovar = "LINESTRING(-122.38975524902344%2037.774187545982066,-122.40983963012695%2037.808508255745316)"
        let radvar = 0.001
        let url = NSURL(string: "https://api-beta.arity.com/safeAlert/v1/location?geometry=" + geovar + "&radius=\(radvar)")!
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            if let httpResponse = response as? HTTPURLResponse{
                print(httpResponse.statusCode)
                if(httpResponse.statusCode != 200){
                    print("error")
                    return
                }
            }
            //print("success1")
            guard error == nil else{
                print(error!)
                return
            }
            //print("success2")
            guard let data = data else {
                print("Data Empty")
                return
            }
            //print("success3")
            let json = JSON(data: data)
            self.severity = json["safeAlertList"]["safeAlertItem"][0]["severity"].string!
            self.accType = json["safeAlertList"]["safeAlertItem"][0]["safeAlertType"].string!
            self.errorMessage(err: self.severity + " risk of " + self.accType + " up ahead")
            
            //DispatchQueue.main.async(execute: self.postReport)
            //DispatchQueue.main.async(execute: self.postDone)
        }
        task.resume()

        
        
        
        
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.pollforUsers(_:)), userInfo: nil, repeats: false)
    }

    
    var updateAnnotationArray : [MGLPointAnnotation] = []
    var annotationArray : [MGLPointAnnotation] = []
    
    //////////////////////////////
    //User Poll for polling for new users in the area
    //////////////////////////////
    func pollforUsers(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let dict = ["user_email":appDelegate.user_email,
                    "location_latitude": self.loc.latitude ,
                    "location_longitude":self.loc.longitude,
                    "destination_latitude": self.dest.coordinate.latitude ,
                    "destination_longitude":self.dest.coordinate.longitude,
                    "driver_status":appDelegate.driver_status] as [String: Any]
        print(dict)
        if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted){
            //print("success")
            //SUBJECT TO URL CHANGE!!!!!
            let url = NSURL(string: "http://138.68.252.198:8000/rideshare/query_ride/")!
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "POST"
            request.setValue("Token \(appDelegate.token)", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request as URLRequest){
                data, response, error in
                if let httpResponse = response as? HTTPURLResponse{
                    print(httpResponse.statusCode)
                    if(httpResponse.statusCode != 200){
                        print("error")
                        return
                    }
                }
                //print("success1")
                guard error == nil else{
                    print(error!)
                    return
                }
                //print("success2")
                guard let data = data else {
                    print("Data Empty")
                    return
                }
                //print("success3")
                let json = JSON(data: data)
                //print(json)
                
                //Clears previous markers
                self.updateAnnotationArray.removeAll()
                let userss = json["user_list"].array
                self.score = json["tagscore"].int!
                
                //print("Arity TagScore:\(json["tagscore"].int)")
                for user in userss! {
                    if user["user_email"].string != appDelegate.user_email {
                        let annotation = MGLPointAnnotation()
                        annotation.coordinate =
                            CLLocationCoordinate2D(latitude: user["location_latitude"].double!,                                                                            longitude: user["location_longitude"].double!)
                        annotation.title = user["user_email"].string
                        if (user["driver_status"].bool == true) {
                            annotation.subtitle = "driver"
                        } else {
                            annotation.subtitle = "rider"
                        }
                        //marker.snippet = "Destination: \(user["destination_longitude"] as! Double)"
                        self.updateAnnotationArray.append(annotation)
                        
                    }
                    
                }
                
                
                DispatchQueue.main.async(execute: self.updateInfo)
                //DispatchQueue.main.async(execute: self.postDone)
            }
            task.resume()
        }
        
    }
    
    var score = 0
    
    func updateInfo() {
        self.arityScore.text = "Arity TagScore:\(self.score)"
        self.mapView.bringSubview(toFront: self.arityScore)
        self.arityScore.isHidden = false
        //updates new markers
        //print("check")
        //var region = mapView.region
        //region.center = CLLocationCoordinate2D(latitude: (locationManager.location?.coordinate.latitude)!,
        //                                       longitude: (locationManager.location?.coordinate.longitude)!)
        //mapView.setRegion(region, animated: true)
        //mapView?.userTrackingMode = .follow
        //mapView.removeAnnotations(annotationArray)
        directionReader()
        annotationArray.removeAll()
        mapView.addAnnotations(updateAnnotationArray)
        for annotation in updateAnnotationArray {
            annotationArray.append(annotation)
        }
        self.timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.pollforUsers(_:)), userInfo: nil, repeats: false)
        self.updateAnnotationArray.removeAll()
    }
    
    var curr = 0
    var madefar = false
    let synthesizer = AVSpeechSynthesizer()
    var started = false
    //////////////////////////////////
    //Read Directions
    //////////////////////////////////
    func directionReader() {
        if self.arr.count > self.curr {
            print("Check")
            
            if (self.started == false) {
                dirLabel.isHidden = false
                dirLabel.text = self.arr[0].narative
                self.started = true
                //let utterance = AVSpeechUtterance(string: dirLabel.text!)
                //utterance.rate = 0.5
                //self.synthesizer.speak(utterance)
            } else {
                // Getting the end point of the step
                let point = self.arr[self.curr].coords
                let location = CLLocation(latitude: loc.latitude, longitude: loc.longitude)
                let location2 = CLLocation(latitude: point.latitude, longitude: point.longitude)
                
                if  Int((location.distance(from: location2))) < 50 {
                    if (madefar) {
                        let utterance = AVSpeechUtterance(string: dirLabel.text!)
                        utterance.rate = 0.5
                        self.synthesizer.speak(utterance)
                        self.madefar  = false
                    }
                }
                    // If the current location is now more than 50 meters away from the last step
                else if (!madefar) {
                    let utterance = AVSpeechUtterance(string: dirLabel.text!)
                    // Speaking the next step
                    utterance.rate = 0.5
                    self.synthesizer.speak(utterance)
                    //self.navigationItem.title = self.arr[self.curr].narative
                    // Updating to the next step
                    self.madefar = true
                    curr+=1
                }
            }
        }
    }
    
    //////////////////////////////////
    //Used to go back to the main page
    //////////////////////////////////
    func backButtonAction(_ button: UIBarButtonItem) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Launch", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "DriverViewController") as! DriverViewController
        
        //Animation Code
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        view.window!.layer.add(transition, forKey: kCATransition)
        
        present(newViewController, animated: false, completion: nil)
        //directions()
        
    }
    
    @IBAction func HideFunction(_ sender: Any) {
        self.AnnotationLabel.isHidden = true
        self.PersonImage.isHidden = true
        self.ChatButton.isHidden = true
        self.HideButton.isHidden = true
        
    }
    
    var chatName : String = ""
    // Tapping the annotation
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        if(self.started) {
            
            print(annotation.title)
            chatName = annotation.title as! String
            let imageName = "yourImage.jpg"
            let image = UIImage(named: imageName)
            self.PersonImage.image = image
            self.AnnotationLabel.text = annotation.title!
            self.mapView.bringSubview(toFront: self.AnnotationLabel)
            self.mapView.bringSubview(toFront: self.PersonImage)
            self.mapView.bringSubview(toFront: self.ChatButton)
            self.mapView.bringSubview(toFront: self.HideButton)
            self.AnnotationLabel.isHidden = false
            self.PersonImage.isHidden = false
            self.ChatButton.isHidden = false
            self.HideButton.isHidden = false
            
            //self.navigationItem.setRightBarButtonItems([backButton, searchButton], animated: true)
        }
        
        
        // Always try to show a callout when an annotation is tapped.
        return true
    }
    
    @IBAction func chatFunction(_ sender: Any) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Arity code down here
    func setupCoreEngine() {
        
        //creates a singleton instance of the DEMDrivingEngineManager
        let sharedEngine  = DEMDrivingEngineManager.sharedManager() as! DEMDrivingEngineManager
        
        //creates a singleton instance of the DEMConfiguration with default configuration
        let engineConfiguration = DEMConfiguration.sharedManager() as DEMConfiguration
        
        /* OPTIONAL : Can set properties of DEMConfiguration as below, with valid values, else default configuration would be set */
        engineConfiguration.enableDeveloperMode = true
        // To detect speeding violation
        engineConfiguration.speedLimit = 40
        // To collect trip's raw data on device storage in developer mode
        engineConfiguration.enableRawDataCollection = false
        //  if webservices enabled/true, engine will submit the trip summary to Arity server
        engineConfiguration.enableWebServices = false
        
        /* Sets tunable configuration parameters within the engine as per the Configuration object passed */
        //An error will thrown for any invalid value passed
        //please check the range of values for each property in DEMConfiguration.h file
        
        sharedEngine.setConfiguration(engineConfiguration)
       
        // Sets the delegate which delivers the engine outputs
        sharedEngine.delegate = self
        
        // Registers for  all the events
        registerForAllEvents()
        
        /* Registers for just individual Event capture: Example Braking as below*/
        //registerForBrakingEvent()
        
        /* Sets the applications desired path for log file collection,Overrides the default path*/
        //sharedEngine.setApplicationPath("**Application path **")
        
        // start Engine
        sharedEngine.startEngine()
    }
    // Register to capture all events
    func registerForAllEvents()  {
        let sharedEngine  = DEMDrivingEngineManager.sharedManager() as! DEMDrivingEngineManager
        // The below registers  for all the events
        sharedEngine.register(for: DEMEventCaptureMask.all)
    }
    
    // Register for braking events only
    func registerForBrakingEvent()  {
        let sharedEngine  = DEMDrivingEngineManager.sharedManager() as! DEMDrivingEngineManager
        // Individual events can also be registered as done below for braking
        sharedEngine.register(for: DEMEventCaptureMask.brakingDetected)
    }
    
    // MARK: DEMDrivingEngineDelegate - Required methods
    
    // Delegate will be fired when trip starts
    //
    func didStartTripRecording(_ drivingEngine: DEMDrivingEngineManager!) -> String! {
        tripIndicator.startAnimating()
        // It should return a unique tripID (40characters) , else SDK would generate a unique tripID from its end.
        return "";
    }
    
    // Delegate  will be fired when trip is completed
    func didStopTripRecording(_ drivingEngine: DEMDrivingEngineManager!)
    {
        tripIndicator.stopAnimating()
    }
    
    // Delegate will be fired at every 5 miles and at the end of the trip, if driveCompletionFlag= true, DEMTripInfo object will contain the entire trip data and trip is considered as completed
    func drivingEngine(_ drivingEngine: DEMDrivingEngineManager!, didSaveTripInformation trip: DEMTripInfo!, driveStatus driveCompletionFlag: Bool){
        //SDK is not completely compliant to Swift 3.0, hence some of the properties appear as implicitly unwrapped optionals in the Swift code
        if (driveCompletionFlag == true) {
            // Few DEMTripInfo object properties
            print("#tripID :",trip.tripID)
            print("#startBatteryLevel:",trip.startBatteryLevel)
            print("#endBatterylevel :",trip.endBatteryLevel)
            print("#startLocation :",trip.startLocation)
            print("#endLocation :",trip.endLocation)
            print("#startTime :",trip.startTime)
            print("#endTime :",trip.endTime)
            print("#distanceCovered :",trip.distanceCovered)
            print("#duration :",trip.duration)
            print("#averageSpeed :",trip.averageSpeed)
            print("#maximumSpeed :",trip.maximumSpeed)
            print("#terminationId :",trip.terminationId)
            print("#speedingCount :",trip.speedingCount)
            
            // Dima's arity server API code here
            // Compose JSON here
            // Data being sent to the server is:
            // tripID - string, startLocation - string, endLocation - string,
            // maximumSpeed - float, speedingCount - int, distanceCovered - float
            //
            
            let dict = ["user_email":"od1@ucsc.edu",
                        "tripid":trip.tripID,
                        "startlocation":trip.startLocation,
                        "endlocation":trip.endLocation,
                        "maximumspeed":trip.maximumSpeed,
                        "speedingcount":trip.speedingCount,
                        "distancecovered":trip.distanceCovered] as [String: Any]
            if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted){
                print("success")
                //SUBJECT TO URL CHANGE!!!!!
                let url = NSURL(string: "http://138.68.252.198:8000/rideshare/get_arity_trip_data/")!
                let request = NSMutableURLRequest(url: url as URL)
                request.httpMethod = "POST"
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpBody = jsonData
                
                let task = URLSession.shared.dataTask(with: request as URLRequest){
                    data, response, error in
                    if let httpResponse = response as? HTTPURLResponse{
                        print(httpResponse.statusCode)
                        if(httpResponse.statusCode != 200){
                            print("error")
                            return
                        }
                    }
                    print("success1")
                    guard error == nil else{
                        print(error!)
                        return
                    }
                    print("success2")
                    guard data != nil else{
                        print("data is empty")
                        return
                    }
                    print("success3")
                    //let json = try! JSONSerialization.jsonObject(with: data, options: []) as AnyObject
                    //print(json)
                }
                task.resume()
            }
            print("SDK data sent to reciever")
            //Dima Arity end
        }
    }
    
    // Delegate will be fired when trip is invalid , i.e does not meet the requirement for a valid trip i.e minimumDistance or minimumDuration have not been met
    func didStopInvalidTripRecording(_ drivingEngine: DEMDrivingEngineManager!){
        
    }
    
    // MARK: DEMDrivingEngineDelegate - Optional methods
    
    // Delegate will be fired whenever any error/warning occurs in SDK
    func drivingEngine(_ drivingEngine: DEMDrivingEngineManager!, didErrorOccur errorInfo: DEMError!) {
        let errorString = errorInfo.category
        print("Error Category:%@",errorString!)
        let errorCodeString = errorInfo.errorCode
        let stringErrorCode = String(errorCodeString)
        print("Error Code:%@",stringErrorCode)
        //errorInf.additionalInfo will return NSDictionary having key value pair
        // LocalizedDescription is the key which has the error descripton against it
        let errorDescription: String? = errorInfo.additionalInfo?.value(forKey: "LocalizedDescription") as! String?
        print("Error Description:%@",errorDescription!)
    }
    
    // Delegate method will be fired when it detects start of a speeding event, DEMEventInfo will have values only till this point
    func drivingEngine(_ drivingEngine: DEMDrivingEngineManager!, didDetectStartOfSpeeding overSpeedingEvent: DEMEventInfo!) {
        self.errorMessage(err: "Reduce your speed!")
        
    }
    
    // Delegate method will be fired when it detects the end  of speeding event, DEMEventInfo will contain the complete event details
    func drivingEngine(_ drivingEngine: DEMDrivingEngineManager!, didDetectEndOfSpeeding overSpeedingEvent: DEMEventInfo!) {
        
    }
    
    // Delegate method will be fired when it detects  an acceleration event,DEMEventInfo will have event details
    func drivingEngine(_ drivingEngine: DEMDrivingEngineManager!, didDetectAcceleration accelerationEvent: DEMEventInfo!) {
        
    }
    
    // Delegate method will be fired when it detects  an braking event,DEMEventInfo will have event details
    func drivingEngine(_ drivingEngine: DEMDrivingEngineManager!, didDetectBraking brakingEvent: DEMEventInfo!) {
        
    }
    
    // Delegate method will be fired when there is a change in GPS horizontalAccuracy, this would be notified irrespective of trip in progress or not
    func didDetectGpsAccuracyChange(_ level: DEMGpsAccuracy) {
        
    }
    
    // Delegate method will be fired  with tripInfo Object when trip is started , The following propeties would contain  values at trip start : tripID, startLocation, startTime and startBatteryLevel
    func didStartTripRecording(with tripInfo: DEMTripInfo!) {
        //SDK is not completely compliant to Swift 3.0, hence some of the properties appear as implicitly unwrapped optionals in the Swift code, hence the if check
        if(tripInfo.tripID != nil)
        {
            print("# TripID :%@",tripInfo.tripID)
        }
        print("# startBatteryLevel : ",tripInfo.startBatteryLevel)
        print("# EndBatteryLevel : ",tripInfo.endBatteryLevel)
        print("# StartLocation : ",tripInfo.startLocation)
        if(tripInfo.endLocation != nil){
            print("# EndLocation :",tripInfo.endLocation)
        }
        print("# StartTime : ",tripInfo.startTime)
        if(tripInfo.endTime != nil){
            print("EndTime : ",tripInfo.endTime)
        }
        print("# DistanceCovered :",tripInfo.distanceCovered)
        print("# Duration :%f",tripInfo.duration)
        print("# Average Speed :",tripInfo.averageSpeed)
        print("# Maximum Speed :",tripInfo.maximumSpeed)
    }
    
    // MARK:  Optional Datasource for Driving engine manager,
    /* Optional : sets the meta data (any additional data to trip info)
           additional data will be uploaded to server and it will be part of DEMTripInfo */
    func metaData(forCurrentTrip drivingEngine: DEMDrivingEngineManager!) -> String! {
        
        return "Send the meta data here - max allowed is 4096 characters (underscore discarded). This is trip specific"
    
    // MARK: Mock button action
    }

}
