//
//  ForgotViewController.swift
//  Slug Ride 2
//
//  Created by Andrew Dato 
//  Copyright © 2017 Andrew Dat0. All rights reserved.
//

import Foundation
import UIKit

class ForgotViewController : UIViewController{
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(r: 227, g: 226, b: 191)
        self.navigationController?.isNavigationBarHidden = false
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func Submit(_ sender: Any) {
        if let text = email.text, !text.isEmpty {
            let dict = ["email":email.text] as [String: Any]
            if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted) {
                let url = NSURL(string: "http://138.68.252.198:8000/rideshare/forgot_password/")!
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
                    DispatchQueue.main.async(execute: self.forgotDone)
                }
                
                task.resume()
                
            }
        }
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
    
    func forgotDone() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! userRatingViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
