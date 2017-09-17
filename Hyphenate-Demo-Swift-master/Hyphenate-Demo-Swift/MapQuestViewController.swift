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

struct dir {
    let coords: CLLocationCoordinate2D
    let narative: String
}

class MapQuestViewController: UIViewController, MGLMapViewDelegate, UISearchBarDelegate {
    @IBOutlet var mapView : MGLMapView!
    fileprivate var searchController: UISearchController!
    
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
    
    //////////////////////////////////
    //Load Code
    //////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        print("check")

        self.view.addSubview(navBar)
        self.AnnotationLabel.isHidden = true
        self.PersonImage.isHidden = true
        self.ChatButton.isHidden = true
        self.HideButton.isHidden = true
        
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
        let alert = UIAlertController(title: "Login Error", message: err, preferredStyle: UIAlertControllerStyle.alert)
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
    
    func postDone() {
        navigationItem.titleView = nil
        let appDelegate = UIApplication.shared.delegate as! AppDelegate        
        
        //let backButton2 = UIBarButtonItem(title: "End Ride", style: UIBarButtonItemStyle.plain, target: self, action: #selector(AppleMapsViewController.endRideButtonAction(_:)))
        //self.navigationItem.rightBarButtonItem = backButton2
        
        
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
    
    func updateInfo() {
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
    
}
