//
//  ChangePictureViewController.swift
//  TagRides
//
//  Created by Andrew Dato on 9/26/17.
//  Copyright © 2017 TagRides. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class ChangePictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var VeriPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func errorMessage(err :String) {
        let alert = UIAlertController(title: "Change Password Error", message: err, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title:"Ok",style: UIAlertActionStyle.default, handler:
            {action in
                
                //set timer for polling again because rider was declined
                //self.timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.pollforRequests(_:)), userInfo: nil, repeats: true)
        }
        ))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func submit(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        var first = ""
        var last = ""
        var pass = ""
        
        
        
        //if let text = firstName.text, !text.isEmpty {
        //    first = firstName.text!
        //}
        
        //if let text = lastName.text, !text.isEmpty {
        //    last = lastName.text!
       // }
        
        if let text = Password.text, !text.isEmpty {
            if (Password.text == VeriPassword.text) {
                pass = Password.text!
            } else {
                errorMessage(err: "Passwords Do not Match")
                return
            }
        }
        
        
        
        
        let dict = ["user_email": appDelegate.user_email, "password": pass,
                    "first_name": first,
                    "last_name": last,
                    "user_car": "",
                    "car_color": "",
                    "car_capacity": 10] as [String: Any]
        print(dict)
        if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted){
            print("success")
            //SUBJECT TO URL CHANGE!!!!!
            let url = NSURL(string: "http://138.68.252.198:8000/rideshare/edit_account_info/")!
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "POST"
            request.setValue("Token \(appDelegate.token)", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request as URLRequest){
                data, response, error in
                if let httpResponse = response as? HTTPURLResponse{
                    print(httpResponse.statusCode)
                    if(httpResponse.statusCode != 201){
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
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        self.present(newViewController, animated: true, completion: nil)
    }
    
    
}
