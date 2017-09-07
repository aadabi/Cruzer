//
//  DriverScheduleViewController.swift
//  Slug Ride 2
//
//  Created by Andrew Dato 
//  Copyright © 2017 Andrew Dat0. All rights reserved.
//
//Not in use Outdated
import Foundation
import UIKit

class DriverScheduleViewController : UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
    }
    @IBOutlet weak var dp_count: UILabel!
    @IBOutlet weak var dp_max: UILabel!
    @IBOutlet weak var dp_location: UILabel!
    @IBOutlet weak var dp_destination: UILabel!
    @IBOutlet weak var dp_time: UILabel!
    @IBOutlet weak var dp_mon: UILabel!
    @IBOutlet weak var dp_tue: UILabel!
    @IBOutlet weak var dp_wed: UILabel!
    @IBOutlet weak var dp_thu: UILabel!
    @IBOutlet weak var dp_fri: UILabel!
    @IBOutlet weak var dp_sat: UILabel!
    @IBOutlet weak var dp_sun: UILabel!
    
    @IBOutlet weak var details_button: UIButton!
    
    var current_id = 0
    var arrJson:AnyObject?
    var max = 1
    var count = 0
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.max = 1
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let dict = ["email":appDelegate.user_email] as [String: Any]
        print(dict)
        if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted) {
            
            print("success")
            let url = NSURL(string: "http://138.68.252.198:8000/rideshare/get_driver_planned_trips/")!
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.rd_tripid = self.current_id
    }
    
    func loadDone() {
        print("load Success")
        var tempCount = 0
        let users = self.arrJson as? [[String: Any]]
        for user in users! {
            if tempCount == count {
                print(user["driver_departure"]!)
                self.current_id = user["trip_id"] as! Int
                dp_location.text = user["driver_departure"] as? String
                dp_destination.text = user["driver_destination"] as? String
                dp_time.text = user["driver_timeofdeparture"] as? String
                if user["monday"] as? Bool == false {
                    dp_mon.text = "Mon"
                } else {
                    dp_mon.text = "Mon X"
                }
                if user["tuesday"] as? Bool == false {
                    dp_tue.text = "Tue"
                } else {
                    dp_tue.text = "Tue X"
                }
                if user["wednesday"] as? Bool == false {
                    dp_wed.text = "Wed"
                } else {
                    dp_wed.text = "Wed X"
                }
                if user["thursday"] as? Bool == false {
                    dp_thu.text = "Thu"
                } else {
                    dp_thu.text = "Thu X"
                }
                if user["friday"] as? Bool == false {
                    dp_fri.text = "Fri"
                } else {
                    dp_fri.text = "Fri X"
                }
                if user["saturday"] as? Bool == false {
                    dp_sat.text = "Sat"
                } else {
                    dp_sat.text = "Sat X"
                }
                if user["sunday"] as? Bool == false {
                    dp_sun.text = "Sun"
                } else {
                    dp_sun.text = "Sun X"
                }
                break
            }
            tempCount+=1
        }
        dp_max.text = "\(self.max-1)"
        dp_count.text = "\(self.count+1)"
    }
    
    @IBAction func SwipeLeft(_ sender: UISwipeGestureRecognizer) {
        print("swipe left")
        if self.count+1 < max-1 {
            self.count += 1
            var tempCount = 0
            let users = self.arrJson as? [[String: Any]]
            for user in users! {
                if tempCount == count {
                    print(user["driver_departure"]!)
                    self.current_id = user["trip_id"] as! Int
                    dp_location.text = user["driver_departure"] as? String
                    dp_destination.text = user["driver_destination"] as? String
                    dp_time.text = user["driver_timeofdeparture"] as? String
                    if user["monday"] as? Bool == false {
                        dp_mon.text = "Mon"
                    } else {
                        dp_mon.text = "Mon X"
                    }
                    if user["tuesday"] as? Bool == false {
                        dp_tue.text = "Tue"
                    } else {
                        dp_tue.text = "Tue X"
                    }
                    if user["wednesday"] as? Bool == false {
                        dp_wed.text = "Wed"
                    } else {
                        dp_wed.text = "Wed X"
                    }
                    if user["thursday"] as? Bool == false {
                        dp_thu.text = "Thu"
                    } else {
                        dp_thu.text = "Thu X"
                    }
                    if user["friday"] as? Bool == false {
                        dp_fri.text = "Fri"
                    } else {
                        dp_fri.text = "Fri X"
                    }
                    if user["saturday"] as? Bool == false {
                        dp_sat.text = "Sat"
                    } else {
                        dp_sat.text = "Sat X"
                    }
                    if user["sunday"] as? Bool == false {
                        dp_sun.text = "Sun"
                    } else {
                        dp_sun.text = "Sun X"
                    }
                    break
                }
                tempCount+=1
            }
            dp_max.text = "\(self.max-1)"
            dp_count.text = "\(self.count+1)"
        }
        
    }
    @IBAction func SwipeRight(_ sender: UISwipeGestureRecognizer) {
        print("swipe right")
        if count > 0 {
            self.count -= 1
            var tempCount = 0
            let users = self.arrJson as? [[String: Any]]
            for user in users! {
                if tempCount == count {
                    print(user["driver_departure"]!)
                    self.current_id = user["trip_id"] as! Int
                    dp_location.text = user["driver_departure"] as? String
                    dp_destination.text = user["driver_destination"] as? String
                    dp_time.text = user["driver_timeofdeparture"] as? String
                    if user["monday"] as? Bool == false {
                        dp_mon.text = "Mon"
                    } else {
                        dp_mon.text = "Mon X"
                    }
                    if user["tuesday"] as? Bool == false {
                        dp_tue.text = "Tue"
                    } else {
                        dp_tue.text = "Tue X"
                    }
                    if user["wednesday"] as? Bool == false {
                        dp_wed.text = "Wed"
                    } else {
                        dp_wed.text = "Wed X"
                    }
                    if user["thursday"] as? Bool == false {
                        dp_thu.text = "Thu"
                    } else {
                        dp_thu.text = "Thu X"
                    }
                    if user["friday"] as? Bool == false {
                        dp_fri.text = "Fri"
                    } else {
                        dp_fri.text = "Fri X"
                    }
                    if user["saturday"] as? Bool == false {
                        dp_sat.text = "Sat"
                    } else {
                        dp_sat.text = "Sat X"
                    }
                    if user["sunday"] as? Bool == false {
                        dp_sun.text = "Sun"
                    } else {
                        dp_sun.text = "Sun X"
                    }
                    break
                }
                tempCount+=1
            }
            dp_max.text = "\(self.max-1)"
            dp_count.text = "\(self.count+1)"
        }
    }
        
        
}
    /*
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
    }
    @IBOutlet weak var dp_count: UILabel!
    @IBOutlet weak var dp_max: UILabel!
    
    var arrJson:AnyObject?
    var max = 1
    var count = 0
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let dict = ["email":appDelegate.user_email] as [String: Any]
        print(dict)
        if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted) {
            
            print("success")
            let url = NSURL(string: "http://localhost:8000/rideshare/get_driver_planned_trips/")!
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func loadDone() {
        print("load Success")
        dp_max.text = "\(self.max-1)"
        dp_count.text = "\(self.count+1)"
    }
     
     override func viewDidLoad() {
     super.viewDidLoad()
     self.navigationController?.isNavigationBarHidden = false
     }
     @IBOutlet weak var dp_count: UILabel!
     @IBOutlet weak var dp_max: UILabel!
     @IBOutlet weak var dp_location: UILabel!
     @IBOutlet weak var dp_destination: UILabel!
     @IBOutlet weak var dp_time: UILabel!
     @IBOutlet weak var dp_mon: UILabel!
     @IBOutlet weak var dp_tue: UILabel!
     @IBOutlet weak var dp_wed: UILabel!
     @IBOutlet weak var dp_thu: UILabel!
     @IBOutlet weak var dp_fri: UILabel!
     @IBOutlet weak var dp_sat: UILabel!
     @IBOutlet weak var dp_sun: UILabel!
     
     @IBOutlet weak var details_button: UIButton!
     
     
     var arrJson:AnyObject?
     var max = 1
     var count = 0
     
     override func viewDidAppear(_ animated: Bool) {
     super.viewDidAppear(animated)
     self.navigationController?.isNavigationBarHidden = false
     
     let appDelegate = UIApplication.shared.delegate as! AppDelegate
     let dict = ["email":appDelegate.user_email] as [String: Any]
     print(dict)
     if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted) {
     
     print("success")
     let url = NSURL(string: "http://localhost:8000/rideshare/get_driver_planned_trips/")!
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
     
     override func viewWillDisappear(_ animated: Bool) {
     super.viewWillDisappear(animated)
     self.navigationController?.isNavigationBarHidden = true
     }
     
     func loadDone() {
     print("load Success")
     let users = self.arrJson as? [[String: Any]]
     for user in users! {
     print(user)
     
     break
     }
     dp_max.text = "\(self.max-1)"
     dp_count.text = "\(self.count+1)"
     }
 */
    

