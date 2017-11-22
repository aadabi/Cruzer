//
//  LoginViewController.swift
//  Slug Ride 2
//
//  Created by Andrew Dato 
//  Copyright © 2017 Andrew Dat0. All rights reserved.
//
//Login Page

import Foundation
import UIKit
import AVFoundation
import Alamofire
import SwiftKeychainWrapper

extension UIColor {
    convenience init(r: Int, g: Int, b: Int) {
        self.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0 , blue: CGFloat(b)/255.0, alpha: 1)
    }
}

class LoginViewController : UIViewController{
    
    
    /////////////////////////////////////////
    //Variables
    /////////////////////////////////////////
    
    var login_session:String = ""
    var user_email:String = ""
    var user_firstname:String = ""
    var user_lastname:String = ""

    
    /////////////////////////////////////////
    //Storyboard Links
    /////////////////////////////////////////
    
    @IBOutlet weak var loginButton: UIButton! //Login Button Variable
    @IBOutlet weak var username_input: UITextField! //User Input Field
    @IBOutlet weak var password_input: UITextField! //Password Input Field
    @IBOutlet weak var login_button: UIButton! //Login button
    
    
    /////////////////////////////////////////
    //AV Functions
    /////////////////////////////////////////
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func playerItemDidReachEnd(notification: Notification) {
        let p: AVPlayerItem = notification.object as! AVPlayerItem
        p.seek(to: kCMTimeZero)
    }
    
    
    /////////////////////////////////////////
    //View Functions
    /////////////////////////////////////////
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        //avPlayer.play() //Plays the video
        //paused = false //Pauses when starts
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //avPlayer.pause() //Pauses the video
        //paused = true //Pauses when leaves
        self.currentTask?.cancel()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        view.backgroundColor = UIColor(r: 227, g: 226, b: 191)
        //view.backgroundColor = UIColor(patternImage: UIImage(named: "Background.jpeg")!)
        self.navigationController?.isNavigationBarHidden = true
        if let username: String = KeychainWrapper.standard.string(forKey: "TagRidesUsername") as? String {
            if let password: String = KeychainWrapper.standard.string(forKey: "TagRidesPassword") as? String{
                login_now(username: username, password: password)
                
            }
        }
        
        
        //Delete Later
        //username_input.text = "od3@ucsc.edu"
        //password_input.text = "od3"
        

    }
    
    //makes top text white
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    /////////////////////////////////////////
    //Button Functions
    /////////////////////////////////////////

    @IBAction func login_submit(_ sender: Any) {
       
        if(login_button.titleLabel?.text == "Logout")
        {
            let preferences = UserDefaults.standard
            preferences.removeObject(forKey: "session")
            
            LoginToDo()
        }
        else{
            //Check to see if the login inforamtion is empty or not
            if let text = username_input.text, !text.isEmpty {
                if let text1 = password_input.text, !text1.isEmpty {
                    login_now(username:username_input.text!, password: password_input.text!)
                } else {
                    self.errorMessage(err: "Please insert valid password")
                }
            } else {
                self.errorMessage(err: "Please insert valid email")
            }
        }
    }
    
    var user:String = ""
    var pass:String = ""
    /////////////////////////////////////////
    //Additional Functions
    /////////////////////////////////////////
    //Login Function
    func login_now(username:String, password:String)
    {
        username_input.isEnabled = false
        password_input.isEnabled = false
        
        login_button.isEnabled = false
        //print("check123")
        
        login_button.setTitle("Logging In...", for: .normal)
        //let session = URLSession.shared
        //Set the login dictoinary
        user = username
        pass = password
        let dict = ["username":username, "password":password] as [String: Any]
        print(dict)
        //Create the JSON File
        if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted) {
            
            print(jsonData)
            let url = NSURL(string: "http://138.68.252.198:8000/rideshare/get_auth_token/")! //Set URl
            //let url = NSURL(string: "http://localhost:8000/rideshare/user_login/")!
            let request = NSMutableURLRequest(url: url as URL) //Set tpe of request
            request.httpMethod = "POST" //Set Type of post
            request.addValue("application/json", forHTTPHeaderField: "Content-Type") //Add additional values
            request.httpBody = jsonData //Set the rest of the object
            
            //Send the JSON object
            let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
                //Check response
                if let httpResponse = response as? HTTPURLResponse {
                    print(httpResponse.statusCode)
                    if(httpResponse.statusCode != 200) {
                        DispatchQueue.main.async(execute: self.errorMessage1)
                        return
                    }
                }
                guard error == nil else {
                    print(error!)
                    return
                }
                guard let data = data else {
                    //self.errorMessage(err: "Data Empty")
                    return
                }
                print(data)
                //Recieve object
                let json = try! JSONSerialization.jsonObject(with: data, options: []) as AnyObject
                print(json)
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.token = json["token"] as! String
                print(appDelegate.token)
                DispatchQueue.main.async(execute: self.LoginStart)

            }
            
            task.resume()
            username_input.isEnabled = true
            password_input.isEnabled = true
            
            login_button.isEnabled = true
            //print("check123")
            
            login_button.setTitle("Login", for: .normal)
        }

    }
    
    
    var currentTask: URLSessionTask?
    func LoginStart() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //let session = URLSession.shared
        //Set the login dictoinary
        let dict = ["email":self.user, "password":self.pass] as [String: Any]
        print(dict)
        //Create the JSON File
        if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted) {
            
            print(jsonData)
            let url = NSURL(string: "http://138.68.252.198:8000/rideshare/user_login/")! //Set URl
            //let url = NSURL(string: "http://localhost:8000/rideshare/user_login/")!
            let request = NSMutableURLRequest(url: url as URL) //Set tpe of request
            request.httpMethod = "POST" //Set Type of post
            request.setValue("Token \(appDelegate.token)", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type") //Add additional values
            request.httpBody = jsonData //Set the rest of the object
            print (request)
            //Send the JSON object
            currentTask = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
                //Check response
                if let httpResponse = response as? HTTPURLResponse {
                    print(httpResponse.statusCode)
                    if(httpResponse.statusCode != 200) {
                        DispatchQueue.main.async(execute: self.errorMessage1)
                        return
                    }
                }
                guard error == nil else {
                    print(error!)
                    return
                }
                guard let data = data else {
                    //self.errorMessage(err: "Data Empty")
                    return
                }
                print(data)
                //Recieve object
                let json = try! JSONSerialization.jsonObject(with: data, options: []) as AnyObject
                print(json)
                DispatchQueue.main.async(execute: self.LoginStart)
                //Check the JSON data
                 if let userEmail = json["email"] as AnyObject? {
                 guard let b = userEmail as? String
                 else {
                 DispatchQueue.main.async(execute: self.errorMessage2)// Was not a string
                 return // needs a return or break here
                 }
                 if b == "" {
                 DispatchQueue.main.async(execute: self.errorMessage2) // Was not a string
                 return // needs a return or break here
                 }
                 self.user_email = b
                 }
                 if let userfirstname = json["first_name"] as AnyObject? {
                 guard let b = userfirstname as? String
                 else {
                 DispatchQueue.main.async(execute: self.errorMessage2) // Was not a string
                 return // needs a return or break here
                 }
                 if b == "" {
                 DispatchQueue.main.async(execute: self.errorMessage2) // Was not a string
                 return // needs a return or break here
                 }
                 self.user_firstname = b
                 }
                 if let userfirstname = json["last_name"] as AnyObject? {
                 guard let b = userfirstname as? String
                 else {
                 DispatchQueue.main.async(execute: self.errorMessage2) // Was not a string
                 return // needs a return or break here
                 }
                 if b == "" {
                 DispatchQueue.main.async(execute: self.errorMessage2) // Was not a string
                 return // needs a return or break here
                 }
                 self.user_lastname = b
                 }
                 //Set the global variables
                
                 appDelegate.user_email = self.user_email
                 appDelegate.user_pass = self.pass
                 appDelegate.user_lastname = self.user_lastname
                 appDelegate.user_firstname = self.user_firstname
                 appDelegate.point_count = (json["point_count"] as? Int)!
                 appDelegate.driver_approval = (json["driver_approval"] as? Bool)!
                 print(json["user_approved"])
                 
                if json["user_approved"] as? Bool == false {
                    DispatchQueue.main.async(execute: self.errorMessage3)
                } else {
                    DispatchQueue.main.async(execute: self.LoginDone)
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
                    self.present(newViewController, animated: true, completion: nil)
                }
                self.currentTask?.cancel()
 
            }
            
            currentTask?.resume()
            username_input.isEnabled = true
            password_input.isEnabled = true
            
            login_button.isEnabled = true
            //print("check123")
            
            login_button.setTitle("Login", for: .normal)
            
        }
    }
    
    func errorMessage2() {
        let alert = UIAlertController(title: "Login Error", message: "Incorrect Login", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title:"Ok",style: UIAlertActionStyle.default, handler:
            {action in
                
                //set timer for polling again because rider was declined
                //self.timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.pollforRequests(_:)), userInfo: nil, repeats: true)
        }
        ))
        self.present(alert, animated: true, completion: nil)
    }
    
    func errorMessage3() {
        let alert = UIAlertController(title: "Login Error", message: "You have not been approved yet, check your email for more information", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title:"Ok",style: UIAlertActionStyle.default, handler:
            {action in
                
                //set timer for polling again because rider was declined
                //self.timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.pollforRequests(_:)), userInfo: nil, repeats: true)
        }
        ))
        self.present(alert, animated: true, completion: nil)
    }

    
    func errorMessage1() {
        let alert = UIAlertController(title: "Login Error", message: "Request failed please try again ", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title:"Ok",style: UIAlertActionStyle.default, handler:
            {action in
                
                //set timer for polling again because rider was declined
                //self.timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.pollforRequests(_:)), userInfo: nil, repeats: true)
        }
        ))
        self.present(alert, animated: true, completion: nil)
    }
    
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
    
    
    
    //Check Login stuff
    func LoginDone()
    {
        //KeychainWrapper.standard.set(self.user_email, forKey: "TagRidesUsername")
        //KeychainWrapper.standard.set(self.pass, forKey: "TagRidesPassword")
        username_input.isEnabled = false
        password_input.isEnabled = false
        
        login_button.isEnabled = false
        //print("check123")

        
        
        
        login_button.setTitle("Logout", for: .normal)
        currentTask?.resume()
    }
    
    func LoginToDo() {
        username_input.isEnabled = true
        password_input.isEnabled = true
        
        login_button.isEnabled = true
        
        
        login_button.setTitle("Login", for: .normal)
    }

    
    
}
