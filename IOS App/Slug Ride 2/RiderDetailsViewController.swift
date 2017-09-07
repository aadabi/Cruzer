//
//  RiderDetailsViewController.swift
//  Slug Ride 2
//
//  Created by Andrew dato on 5/2/17.
//  Copyright © 2017 Andrew Dat0. All rights reserved.
//

import Foundation
import UIKit

class RiderDetailsViewController : UIViewController{
    
    @IBOutlet weak var rd_count: UILabel!
    @IBOutlet weak var rd_max: UILabel!
    
    @IBOutlet weak var rd_firstname: UILabel!
    @IBOutlet weak var rd_lastname: UILabel!
    @IBOutlet weak var rd_location: UILabel!
    @IBOutlet weak var rd_destination: UILabel!
    @IBOutlet weak var rd_time: UILabel!
    @IBOutlet weak var rd_email: UILabel!
    @IBOutlet weak var rd_status: UILabel!

    var rider_email:String = ""
    var arrJson:AnyObject?
    var max = 1
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        loadRiders()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func loadRiders() {
        self.max = 1
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let dict = ["email":appDelegate.user_email, "trip_id":appDelegate.rd_tripid] as [String: Any]
        print(dict)
        if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted) {
            
            print("success")
            let url = NSURL(string: "http://138.68.252.198:8000/rideshare/get_riders_on_trip/")!
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
                if let httpResponse = response as? HTTPURLResponse {
                    print(httpResponse.statusCode)
                    if(httpResponse.statusCode != 201) {
                        print("error")
                        return
                    }
                }
                guard error == nil else {
                    print(error!)
                    return
                }
                guard let data = data else {
                    print("Data is empty")
                    return
                }
                let json = try! JSONSerialization.jsonObject(with: data, options: []) as AnyObject
                print(json)
                self.arrJson = json
                print(self.arrJson!)
                
                
                let users = self.arrJson as? [[String: Any]]
                for user in users! {
                    print(user)
                    self.max += 1
                }
                print(self.max)
                DispatchQueue.main.async(execute: self.loadDone)
                //let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                //let newViewController = storyBoard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
                //self.present(newViewController, animated: true, completion: nil)
            }
            
            task.resume()
            
        }
    }
    
    func loadRiderData() {
        var tempCount = 0
        let users = self.arrJson as? [[String: Any]]
        for user in users! {
            if tempCount == count {
                rd_firstname.text = user["rider_firstname"] as? String
                rd_lastname.text = user["rider_lastname"] as? String
                rd_location.text = user["rider_location"] as? String
                rd_destination.text = user["rider_destination"] as? String
                rd_time.text = user["rider_timeofdeparture"] as? String
                rd_email.text = user["rider_email"] as? String
                self.rider_email = user["rider_email"] as! String
                if user["rider_approved"] as? Bool == false {
                    rd_status.text = "Pending"
                } else {
                    rd_status.text = "Approved"
                }
                break                }
            tempCount+=1
        }
        rd_max.text = "\(self.max-1)"
        rd_count.text = "\(self.count+1)"
    }
    
    func loadDone() {
        print("load Success")
        loadRiderData()
    }
    
    @IBAction func SwipeLeft(_ sender: UISwipeGestureRecognizer) {
        print("swipe left")
        if self.count+1 < max-1 {
            self.count += 1
            loadRiderData()
        }
        
    }
    @IBAction func SwipeRight(_ sender: UISwipeGestureRecognizer) {
        print("swipe right")
        if count > 0 {
            self.count -= 1
            loadRiderData()
        }
    }
    
    @IBAction func approved_press(_ sender: Any) {
        sendApproval(desicion:true)
    }
    @IBAction func deny_press(_ sender: Any) {
        sendApproval(desicion: false)
    }
    
    func sendApproval(desicion:Bool){
        print(desicion)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let dict = ["driver_email":appDelegate.user_email, "rider_email" : self.rider_email, "trip_id":appDelegate.rd_tripid,
                    "rider_approval": desicion] as [String: Any]
        print(dict)
        if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted) {
            
            print("success")
            let url = NSURL(string: "http://138.68.252.198:8000/rideshare/rider_approval/")!
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
                if let httpResponse = response as? HTTPURLResponse {
                    print(httpResponse.statusCode)
                    if(httpResponse.statusCode != 201) {
                        print("error")
                        return
                    }
                }
                guard error == nil else {
                    print(error!)
                    return
                }
                guard let data = data else {
                    print("Data is empty")
                    return
                }
                self.count  = 0
                /*
                self.arrJson = json
                print(self.arrJson!)
                
                
                let users = self.arrJson as? [[String: Any]]
                for user in users! {
                    print(user)
                    self.max += 1
                }
                print(self.max*/
                DispatchQueue.main.async(execute: self.loadRiders)
                //let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                //let newViewController = storyBoard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
                //self.present(newViewController, animated: true, completion: nil)
            }
            
            task.resume()
            
        }
    }
}

