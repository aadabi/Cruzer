//
//  RiderOnDemandSubmitViewController.swift
//  Slug Ride 2
//
//  Created by Andrew Dato 
//  Copyright © 2017 Andrew Dat0. All rights reserved.
//
//
//  RiderOnDemandSubmitViewController.swift
//  Slug Ride 2
//
//  Created by Andrew Dato
//  Copyright © 2017 Andrew Dat0. All rights reserved.
//
/*
 * QRCodeReader.swift
 *
 * Copyright 2014-present Yannick Loriot.
 * http://yannickloriot.com
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 */

import AVFoundation
import Foundation
import UIKit
import GoogleMaps
import GooglePlaces
import SwiftyJSON
import Alamofire

struct UserProfile {
    let user_email: String
    let driver_status: Bool
    let location_longitude: Double
    let location_latitude: Double
    let destination_longitude: Double
    let destination_latitude: Double
}

class RiderOnDemandSubmitViewController : UIViewController , GMSMapViewDelegate ,  CLLocationManagerDelegate, QRCodeReaderViewControllerDelegate{
    
    
    //////////////////////////////
    //Outlet Variables
    //////////////////////////////
    @IBOutlet weak var googleMaps: GMSMapView!
    @IBOutlet weak var startLocation: UITextField!
    @IBOutlet weak var destinationLocation: UITextField!
    
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var wptLocation: UITextField!
    
    @IBOutlet weak var QRreader: UIButton!
    @IBOutlet weak var QRCode: UIImageView!
    @IBOutlet weak var endRide: UIButton!
    @IBOutlet weak var submit: UIButton!
    @IBOutlet weak var gmButton: UIButton!
    @IBOutlet weak var coins: UILabel!
    @IBOutlet weak var updateRoute: UIButton!

    
    
    

    //////////////////////////////
    //Timer Variable
    //////////////////////////////
    var timer = Timer()
    
    
    
    var locationManager = CLLocationManager()
    var locationSelected = Location.startLocation
    
    var arrJson:AnyObject?
    
    
    //var for current user data
    var curLocation = CLLocation()
    var locationStart = CLLocation()
    var locationEnd = CLLocation()
    var locationWaypoint = CLLocation()
    var isthereaWpt = false;
    
    
    //var for driver info from server
    var driverEmail: String!
    var driverdepart_lat: Double!
    var driverdepart_lon: Double!
    var driverdest_lat: Double!
    var driverdest_lon: Double!
    
    
    //vars for reverse geolocation
    var revLoc: String!
    var revLoc2: String!
    
    
    //var for driver received data
    var driverLocationStart = CLLocation()
    var driverLocationEnd = CLLocation()
    
    var userList = [UserProfile]()
    var markerList = [GMSMarker]()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //self.navigationController?.isNavigationBarHidden = true
    }
    
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //self.navigationController?.isNavigationBarHidden = true
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //Hide all of the buttons
        self.updateRoute.isHidden = true
        self.QRCode.isHidden = true
        self.postButton.isHidden = true
        self.QRreader.isHidden = true
        self.endRide.isHidden = true
        
        //self.postButton.layer.borderWidth = 5
        self.coins.text = "\(appDelegate.point_count)"
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
        
        self.navigationController?.isNavigationBarHidden = false
        
    }
    
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
        
        
        //gets the current location and puts it into a global variable to be used in other functions
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
    

    //Function to create a Marker when tapped
    
    /*
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("COORDINATE \(coordinate)") // when you tapped coordinate
        
        //clear the marker from before
        self.googleMaps.clear()
        
        //set the coordinate to the start point
        self.locationStart = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
            
        createMarker(titleMarker: "Departure", iconMarker: #imageLiteral(resourceName: "drivericon3"), latitude: coordinate.latitude, longitude: coordinate.longitude)
    }*/
    
    
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        googleMaps.isMyLocationEnabled = true
        googleMaps.selectedMarker = nil
        return false
    }
    
    
    
    //MARK: - this is function for create direction path, from start location to desination location
    
    func drawPath(startLocation: CLLocation, endLocation: CLLocation, waypoints: CLLocation)
    {
        
        
        
        //Uses current location as the first point in route instead of using input location
        //let origin = "\(curLocation.coordinate.latitude),\(curLocation.coordinate.longitude)"
        
        let origin = "\(startLocation.coordinate.latitude),\(startLocation.coordinate.longitude)"
        let destination = "\(endLocation.coordinate.latitude),\(endLocation.coordinate.longitude)"
        //let wpt = "\(waypoints.coordinate.latitude),\(waypoints.coordinate.longitude)"
        
        //url request with waypoints
        //        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&waypoints=\(wpt)&mode=driving"
        
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving"
        
        Alamofire.request(url).responseJSON { response in
            
            //print(response.request as Any)  // original URL request
            //print(response.response as Any) // HTTP URL response
            //print(response.data as Any)     // server data
            //print(response.result as Any)   // result of response serialization
            
            let json = JSON(data: response.data!)
            let routes = json["routes"].arrayValue
            
            //print(" JSON is:")
            //print(json)
            
//            let jsonRoutes = json["routes"]
//            print("*****-------------jsonRoutes----------------*****")
//            print(jsonRoutes)
//            
//            var duration = jsonRoutes.arrayObject as! [[String: Any]]
//            print("*****-------------DURATION----------------*****")
//            print(duration)
            
//            let one = json.dictionaryObject
//            print("*****-------------dictionary Object----------------*****")
//            print(one)
            
            var two = json.dictionaryValue
            //print("*****-------------dictionary value----------------*****")
            //print(two)
            
            let three = two
            //print("*****-------------count of Dict Value----------------*****")
            //print(three)
//            let three = json.dictionary
//            print("*****-------------dictionary----------------*****")
//            print(three)
//            
//            let four = json.arrayValue
//            print("*****-------------array Value----------------*****")
//            print(four)
            
            // print route using Polyline
            for route in routes
            {
                let routeOverviewPolyline = route["overview_polyline"].dictionary
                let points = routeOverviewPolyline?["points"]?.stringValue
                let path = GMSPath.init(fromEncodedPath: points!)
                let polyline = GMSPolyline.init(path: path)
                
            
                
                var routeLegs = route["legs"].arrayValue
                
                
                //print("Route Legs")
                //print(routeLegs)
                
                
                
                
                
                //print("Apple API Distance:")
                //print(startLocation.distance(from: endLocation)/1609.34)
                
                //Google Maps distance is accurate based on route
                //print("Google Maps Distance:")
                var variablex = (GMSGeometryLength(path!)/1609.34)
               
                //print(variablex)
                
                //self.routeDistance.text  = "\(GMSGeometryLength(path!)/1609.34)"
             
                
                
                //"\((GMSGeometryLength(path!)/1609.34))"
                
                
                
                polyline.strokeWidth = 4
                polyline.strokeColor = UIColor.black
                polyline.map = self.googleMaps
                

                /*
                //this code sets the camera of Google Maps to view the entire route
                let x: UInt!
                x = 1
                
                var bounds = GMSCoordinateBounds()
                for index in x...(path?.count())!{
                    bounds = bounds.includingCoordinate((path?.coordinate(at: index))!)
                    
                }
                
                self.googleMaps.animate(with: GMSCameraUpdate.fit(bounds))
                
                // CODE TO CHANGE ALERT AFTER GETTING ROUTE
                let alert = UIAlertController(title: "Route", message: "Looking for Drivers...  Route is \(variablex.truncate(places: 2)) miles long ", preferredStyle: UIAlertControllerStyle.actionSheet)
                
                self.present(alert, animated: true, completion: nil)
                alert.addAction(UIAlertAction(title: "Press Post Ride to begin", style: UIAlertActionStyle.default, handler: {action in
                    print("Done")
                }))
                */
            }
            
            
            
        }
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
    
    
    
    //////////////////////////////
    //This is the function for driver
    //to display his QR Code
    //////////////////////////////
    @IBAction func riderPostRide(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let image = generateQrImage(from: appDelegate.user_email)
        self.QRCode.image = image
        
        if(self.QRCode.isHidden == false) {
            self.postButton.setTitle("Display QR Code",for: .normal)
            self.QRCode.isHidden = true
        } else {
            self.postButton.setTitle("Hide Code",for: .normal)
            self.QRCode.isHidden = false
        }
    }
    
    //////////////////////////////
    //This is the submit button function
    //////////////////////////////
    @IBAction func showDirection(_ sender: UIButton) {
        if let text = destinationLocation.text, !text.isEmpty{
            print(curLocation)
            print(locationEnd)
                
                // when button direction tapped, must call drawpath func
            self.drawPath(startLocation: curLocation, endLocation: locationEnd,waypoints: locationWaypoint)
            print("check0")
                
            //GMSCameraPosition.camera(withLatitude: curLocation.coordinate.latitude, longitude: curLocation.coordinate.longitude, zoom: 14.0)

            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let dict = ["user_email":appDelegate.user_email,"location_latitude": curLocation.coordinate.latitude ,"location_longitude":curLocation.coordinate.longitude,"destination_latitude": locationEnd.coordinate.latitude ,"destination_longitude":locationEnd.coordinate.longitude, "driver_status":appDelegate.driver_status] as [String: Any]
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

        } else {
            let alert = UIAlertController(title: "Submit Error", message: "Please insert a destination", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title:"Ok",style: UIAlertActionStyle.default, handler:
                {action in}
            ))
            self.present(alert, animated: true, completion: nil)
        }
        
        
    }
    
    //////////////////////////////
    //Function to change the screen once the
    //JSON has been sent out
    //////////////////////////////
    func postDone() {
        self.navigationController?.isNavigationBarHidden = true
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.postButton.isHidden = false
        self.submit.isHidden = true
        self.endRide.isHidden = false
        self.gmButton.isHidden = true
        self.updateRoute.isHidden = false
        print("success4")
        if (appDelegate.driver_status == false) {
            self.QRreader.isHidden = false
        } else {
            self.postButton.isHidden = false
        }
        let camera = GMSCameraPosition.camera(withLatitude: self.curLocation.coordinate.latitude, longitude: self.curLocation.coordinate.longitude, zoom: 15.0)
        self.googleMaps.camera = camera
        self.timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.pollforUsers(_:)), userInfo: nil, repeats: true)
    }
    
    
    //////////////////////////////
    //User Poll for polling for new users in the area
    //////////////////////////////
    func pollforUsers(_ sender: Any) {
        print(curLocation)
        print(locationEnd)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let dict = ["user_email":appDelegate.user_email,"location_latitude": curLocation.coordinate.latitude ,"location_longitude":curLocation.coordinate.longitude,"destination_latitude": locationEnd.coordinate.latitude ,"destination_longitude":locationEnd.coordinate.longitude, "driver_status":appDelegate.driver_status] as [String: Any]
        print(dict)
        if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted){
            print("success")
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
                let json = try! JSONSerialization.jsonObject(with: data, options: []) as AnyObject
                print(json)
                
                //Clears previous markers
                for marker in self.markerList {
                    marker.map = nil
                }
                self.markerList.removeAll()
                let userss = json["user_list"] as? [[String: Any]]
                for user in userss! {
                    if user["user_email"] as! String != appDelegate.user_email {
                        let position = CLLocationCoordinate2D(latitude: user["location_latitude"] as! Double,
                                                              longitude: user["location_longitude"] as! Double)
                        let marker = GMSMarker(position: position)
                        marker.title = user["user_email"] as? String
                        if (user["driver_status"] as! Bool == true) {
                            marker.icon = GMSMarker.markerImage(with: .red)
                        } else {
                            marker.icon = GMSMarker.markerImage(with: .blue)
                        }
                        marker.snippet = "Destination: \(user["destination_longitude"] as! Double)"
                        self.markerList.append(marker)
                    }
                    
                }
                print(self.userList)
                
                
                DispatchQueue.main.async(execute: self.updateInfo)
                //DispatchQueue.main.async(execute: self.postDone)
            }
            task.resume()
        }

    }
    
    func updateInfo() {
        //updates new markers
        for marker in markerList {
            marker.map = self.googleMaps
        }
    }
    
    //Update route if the user leaves the route
    @IBAction func routeUpdate(_ sender: Any) {
        self.drawPath(startLocation: curLocation, endLocation: locationEnd,waypoints: locationWaypoint)
        let camera = GMSCameraPosition.camera(withLatitude: self.curLocation.coordinate.latitude, longitude: self.curLocation.coordinate.longitude, zoom: 15.0)
        self.googleMaps.camera = camera
    }
    
    //////////////////////////////
    //QR Code Generator Stuff
    //////////////////////////////
    func generateQrImage(from text: String) -> UIImage?{
        let data = text.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator"){
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y:3)
            if let output = filter.outputImage?.applying(transform){
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
    
    //////////////////////////////
    //QR Code Reader Stuff
    //////////////////////////////
    @IBOutlet weak var previewView: UIView!
    lazy var reader: QRCodeReader = QRCodeReader()
    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [AVMetadataObjectTypeQRCode], captureDevicePosition: .back)
            $0.showTorchButton = true
        }
        
        return QRCodeReaderViewController(builder: builder)
    }()
    
    // MARK: - Actions
    
    private func checkScanPermissions() -> Bool {
        do {
            return try QRCodeReader.supportsMetadataObjectTypes()
        } catch let error as NSError {
            let alert: UIAlertController?
            
            switch error.code {
            case -11852:
                alert = UIAlertController(title: "Error", message: "This app is not authorized to use Back Camera.", preferredStyle: .alert)
                
                alert?.addAction(UIAlertAction(title: "Setting", style: .default, handler: { (_) in
                    DispatchQueue.main.async {
                        if let settingsURL = URL(string: UIApplicationOpenSettingsURLString) {
                            UIApplication.shared.openURL(settingsURL)
                        }
                    }
                }))
                
                alert?.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            case -11814:
                alert = UIAlertController(title: "Error", message: "Reader not supported by the current device", preferredStyle: .alert)
                alert?.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            default:
                alert = nil
            }
            
            guard let vc = alert else { return false }
            
            present(vc, animated: true, completion: nil)
            
            return false
        }
    }
    
    @IBAction func scanInModalAction(_ sender: AnyObject) {
        guard checkScanPermissions() else { return }
        
        readerVC.modalPresentationStyle = .formSheet
        readerVC.delegate               = self
        
        readerVC.completionBlock = { (result: QRCodeReaderResult?) in
            if let result = result {
                print("Completion with result: \(result.value) of type \(result.metadataType)")
            }
        }
        
        present(readerVC, animated: true, completion: nil)
    }
    // MARK: - QRCodeReader Delegate Methods
    
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        reader.stopScanning()
        
        dismiss(animated: true) { [weak self] in
            
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let dict = ["user_email":appDelegate.user_email,"driver_email":result.value] as [String: Any]
            print(dict)
            if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted){
                print("success")
                let url = NSURL(string: "http://138.68.252.198:8000/rideshare/scan_qr_code/")!
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
                    guard let data = data else {
                        print("Data Empty")
                        return
                    }
                    print("success3")
                    let json = try! JSONSerialization.jsonObject(with: data, options: []) as AnyObject
                    print(json)
                    appDelegate.point_count = (json["user_points"] as? Int)!
                    let approveCheck = json["approved"] as? Bool
                    if (approveCheck == true) {
                        let alert = UIAlertController(
                            title: "Driver Approved",
                            message: String (format:"Enjoy your ride"),
                            preferredStyle: .alert
                        )
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                        
                        self?.present(alert, animated: true, completion: nil)
                        if self?.timer != nil {
                            self?.timer.invalidate()
                        }
                        self?.coins.text = "\(appDelegate.point_count)"
                    } else {
                        let alert = UIAlertController(
                            title: "Driver Not Approved",
                            message: String (format:"Ride not approved please try again or wait for another driver"),
                            preferredStyle: .alert
                        )
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                        
                        self?.present(alert, animated: true, completion: nil)
                    }
                    //DispatchQueue.main.async(execute: self.postDone)
                    
                }
                task.resume()
            }
            
            //This is where I should add the code to get the QR Code Scanner working.

        }
    }
    
    func reader(_ reader: QRCodeReaderViewController, didSwitchCamera newCaptureDevice: AVCaptureDeviceInput) {
        if let cameraName = newCaptureDevice.device.localizedName {
            print("Switching capturing to: \(cameraName)")
        }
    }
    
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        reader.stopScanning()
        
        dismiss(animated: true, completion: nil)
    }

    @IBAction func CoinMove(_ sender: Any) {
        let newViewController = MarketViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    @IBAction func rideEnding(_ sender: Any) {
        if self.timer != nil {
            self.timer.invalidate()
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let dict = ["user_email":appDelegate.user_email] as [String: Any]
        print(dict)
        if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted){
            print("success")
            let url = NSURL(string: "http://138.68.252.198:8000/rideshare/end_ride/")!
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
                guard let data = data else {
                    print("Data Empty")
                    return
                }
                print("success3")
                let json = try! JSONSerialization.jsonObject(with: data, options: []) as AnyObject
                print(json)
                appDelegate.ratingList.removeAll()
                let userss = json["user_emails"] as? [String]
                var count = 0
                for user in userss! {
                    count = 1
                    appDelegate.ratingList.append(user)
                }
                print (count)
                print(appDelegate.ratingList)
                if count != 0 {
                    DispatchQueue.main.async(execute: self.gotoRating)
                } else {
                    DispatchQueue.main.async(execute: self.gotoMenu)
                }
            }
            task.resume()
        }
 
    }
    @IBAction func settings(_ sender: Any) {
        let newViewController = AccountInformationViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func gotoRating() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "userRatingViewController") as! userRatingViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func gotoMenu() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        self.present(newViewController, animated: true, completion: nil)
    }
    
}

// MARK: - GMS Auto Complete Delegate, for autocomplete search location
extension RiderOnDemandSubmitViewController: GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error \(error)")
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        // Change map location
        let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 16.0
        )
        
        // set coordinate to text
        if locationSelected == .startLocation {
            startLocation.text = place.name
            locationStart = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
            createMarker(titleMarker: "Location Start", iconMarker: #imageLiteral(resourceName: "mapspin"), latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        } else if locationSelected == .destinationLocation {
            destinationLocation.text = place.name	
            locationEnd = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
            createMarker(titleMarker: "Location End", iconMarker: #imageLiteral(resourceName: "drivericon4"), latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
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
    
    public func setTextColor(color: UIColor) {
        let svs = subviews.flatMap { $0.subviews }
        guard let tf = (svs.filter { $0 is UITextField }).first as? UITextField else { return }
        tf.textColor = color
    }
    
}
public extension Double
{
    func truncate(places : Int)-> Double
    {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
}
