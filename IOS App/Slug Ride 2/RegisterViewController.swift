//
//  RegisterViewController.swift
//  Slug Ride 2
//
//  Created by Andrew Dato 
//  Copyright © 2017 Andrew Dat0. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class RegisterViewController : UIViewController{
    
    
    /////////////////////////////////////////
    //Variables
    /////////////////////////////////////////
    
    //AV player variables
    var avPlayer: AVPlayer!
    var avPlayerLayer: AVPlayerLayer!
    var paused: Bool = false
    
    let login_url = "http://localhost:8000/rideshare/user_registration/"
    
    //Linking variables
    @IBOutlet weak var email_register: UITextField!
    @IBOutlet weak var firstname_register: UITextField!
    @IBOutlet weak var lastname_register: UITextField!
    @IBOutlet weak var password_register: UITextField!
    @IBOutlet weak var submit_register: UIButton!
    @IBOutlet weak var password_verify: UITextField!
    
    /////////////////////////////////////////
    //View Functions
    /////////////////////////////////////////
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func playerItemDidReachEnd(notification: Notification) {
        let p: AVPlayerItem = notification.object as! AVPlayerItem
        p.seek(to: kCMTimeZero)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        avPlayer.play()
        paused = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        avPlayer.pause()
        paused = true
        self.navigationController?.isNavigationBarHidden = true
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Video File used
        if let theURL: NSURL = Bundle.main.url(forResource: "ridervid2", withExtension: "mp4")! as NSURL{
            avPlayer = AVPlayer(url: theURL as URL)
            
        }
        
        //AV player attributes
        avPlayerLayer = AVPlayerLayer(player: avPlayer)
        avPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        avPlayer.volume = 0
        avPlayer.actionAtItemEnd = .none
        
        
        avPlayerLayer.frame = view.layer.bounds
        view.backgroundColor = .clear
        view.layer.insertSublayer(avPlayerLayer, at: 0)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerItemDidReachEnd(notification:)),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: avPlayer.currentItem)
        
        self.navigationController?.isNavigationBarHidden = false
        
    }
    
    /////////////////////////////////////////
    //Button Functions
    /////////////////////////////////////////
    @IBAction func SubmitButton(_ sender: Any) {
        //Check to make sure every field is filled out
        if let text = email_register.text, !text.isEmpty {
            if let text1 = firstname_register.text, !text1.isEmpty {
                if let text2 = lastname_register.text, !text2.isEmpty {
                    if let text3 = password_register.text, !text3.isEmpty {
                        if let text4 = password_verify.text, !text4.isEmpty{
                            if (password_verify.text == password_register.text) {
                                register_now(email:email_register.text!, password: password_register.text!, firstname: firstname_register.text!, lastname:  lastname_register.text!)
                            } else {
                              self.errorMessage(err: "Passwords do not match up")
                            }
                        } else {
                          self.errorMessage(err: "Please verify password")
                        }
                    } else {
                      self.errorMessage(err: "Please enter password")
                    }
                } else {
                  self.errorMessage(err: "please enter last name")
                }
            } else {
                self.errorMessage(err: "Please enter first name")
            }
        } else {
            self.errorMessage(err: "Please enter email")
        }
    }
    
    /////////////////////////////////////////
    //Additional Functions
    /////////////////////////////////////////
    //Main Registration Function
    func register_now(email:String, password:String, firstname:String, lastname:String)
    {
        //Observe Login page to understand what is going on here
        let dict = ["first_name":firstname, "last_name":lastname, "email":email, "password":password, "share_code":""] as [String: Any]
        if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted) {
            let url = NSURL(string: "http://138.68.252.198:8000/rideshare/user_registration/")!
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData

            let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
                if let httpResponse = response as? HTTPURLResponse {
                    print(httpResponse.statusCode)
                    if(httpResponse.statusCode != 201) {
                        self.errorMessage(err: "Server Down")
                        return
                    }
                }
                guard error == nil else {
                    print(error!)
                    return
                }
                guard let data = data else {
                    self.errorMessage(err: "Data Empty")
                    return
                }
                
                
                //let json = try! JSONSerialization.jsonObject(with: data, options: [])
                //print(json)
                DispatchQueue.main.async(execute: self.RegisterDone)

            }
            
            task.resume()
            
        }
    }
    
    func errorMessage(err :String) {
        let alert = UIAlertController(title: "Registration Error", message: err, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title:"Ok",style: UIAlertActionStyle.default, handler:
            {action in}
        ))
        self.present(alert, animated: true, completion: nil)
    }
    
    //Set all the fields to false after finishing
    func RegisterDone()
    {
        email_register.isEnabled = false
        password_register.isEnabled = false
        firstname_register.isEnabled = false
        lastname_register.isEnabled = false
        password_verify.isEnabled = false
        
        submit_register.isEnabled = false
        
        
        submit_register.setTitle("Registered!", for: .normal)
    }
}
