//
//  EditDriverViewController.swift
//  TagRides
//
//  Created by Andrew Dato on 9/26/17.
//  Copyright © 2017 TagRides. All rights reserved.
//

import Foundation
import UIKit

class EditDriverViewController: UIViewController {
    
    @IBOutlet weak var carColor: UITextField!
    @IBOutlet weak var carModel: UITextField!
    @IBOutlet weak var carCapacity: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func Submit(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        var color = ""
        var model = ""
        var cap = 10
        
        
        
        if let text = carColor.text, !text.isEmpty {
            color = carColor.text!
        }
        
        if let text = carModel.text, !text.isEmpty {
            model = carModel.text!
        }
        
        //if let text = carModel.text, !text.isEmpty {
        //    model = carModel.text!
        //}

        
        
        
        let dict = ["password": "",
                    "first_name": "",
                    "last_name": "",
                    "user_car": color,
                    "car_color": model,
                    "car_capacity": cap] as [String: Any]
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
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        self.present(newViewController, animated: true, completion: nil)
    }
}
