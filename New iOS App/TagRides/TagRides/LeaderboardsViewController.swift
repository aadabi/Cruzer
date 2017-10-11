//
//  LeaderboardsViewController.swift
//  TagRides
//
//  Created by Andrew Dato on 9/26/17.
//  Copyright © 2017 TagRides. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire

struct leaderUser {
    let user_email : String
    let user_lastname : String
    let point_count : Int
    let user_firstname : String
    
}

class LeaderboardsViewController : UITableViewController{

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var pic1: UIImageView!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var pic2: UIImageView!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var pic3: UIImageView!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var pic4: UIImageView!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var pic5: UIImageView!
    @IBOutlet weak var label6: UILabel!
    @IBOutlet weak var pic6: UIImageView!
    @IBOutlet weak var label7: UILabel!
    @IBOutlet weak var pic7: UIImageView!
    @IBOutlet weak var label8: UILabel!
    @IBOutlet weak var pic8: UIImageView!
    @IBOutlet weak var label9: UILabel!
    @IBOutlet weak var pic9: UIImageView!
    @IBOutlet weak var label10: UILabel!
    @IBOutlet weak var pic10: UIImageView!
    
    var arr : [leaderUser] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        view.backgroundColor = UIColor(r: 227, g: 226, b: 191)
        let url = NSURL(string: "http://138.68.252.198:8000/rideshare/get_leaderboards/")!
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "GET"
        request.setValue("Token \(appDelegate.token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
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
            print(json	)
            for user in json.array! {
                self.arr.append(leaderUser(user_email: user["user_email"].string!, user_lastname: user["user_lastname"].string!, point_count: user["user_points"].int!, user_firstname: user["user_firstname"].string!))
            }
            print(self.arr)
            DispatchQueue.main.async(execute: self.gatherDone)
        }
        task.resume()

        
    }

    func gatherDone() {
        if self.arr.count > 0 {
            label1.text = "Name: \(arr[0].user_firstname) \(String(arr[0].user_lastname.characters.prefix(1))). Points: \(arr[0].point_count)"
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let headers = ["Authorization": "Token \(appDelegate.token)"]
            let parameters = ["user_email": arr[0].user_email]
            
            Alamofire.request("http://138.68.252.198:8000/rideshare/get_profile_photo/", method: .get, parameters: parameters, headers: headers ).responseData { (dataResponse) in
                
                if let data = dataResponse.data {
                    //self.ImageView.image = UIImage(data: data)
                    //print(data)
                    if let image = UIImage (data:data) {
                        self.pic1.image = image
                    }
                }
            }
        }
        
        if self.arr.count > 1 {
            label2.text = "Name: \(arr[1].user_firstname) \(String(arr[1].user_lastname.characters.prefix(1))). Points: \(arr[1].point_count)"
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let headers = ["Authorization": "Token \(appDelegate.token)"]
            let parameters = ["user_email": arr[1].user_email]
            
            Alamofire.request("http://138.68.252.198:8000/rideshare/get_profile_photo/", method: .get, parameters: parameters, headers: headers ).responseData { (dataResponse) in
                
                if let data = dataResponse.data {
                    //self.ImageView.image = UIImage(data: data)
                    //print(data)
                    if let image = UIImage (data:data) {
                        self.pic2.image = image
                    }
                }
            }
        }
        
        if self.arr.count > 2 {
            label3.text = "Name: \(arr[2].user_firstname) \(String(arr[2].user_lastname.characters.prefix(1))). Points: \(arr[2].point_count)"
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let headers = ["Authorization": "Token \(appDelegate.token)"]
            let parameters = ["user_email": arr[2].user_email]
            
            Alamofire.request("http://138.68.252.198:8000/rideshare/get_profile_photo/", method: .get, parameters: parameters, headers: headers ).responseData { (dataResponse) in
                
                if let data = dataResponse.data {
                    //self.ImageView.image = UIImage(data: data)
                    //print(data)
                    if let image = UIImage (data:data) {
                        self.pic3.image = image
                    }
                }
            }
        }
        
        if self.arr.count > 3 {
            label4.text = "Name: \(arr[3].user_firstname) \(String(arr[3].user_lastname.characters.prefix(1))). Points: \(arr[3].point_count)"
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let headers = ["Authorization": "Token \(appDelegate.token)"]
            let parameters = ["user_email": arr[3].user_email]
            
            Alamofire.request("http://138.68.252.198:8000/rideshare/get_profile_photo/", method: .get, parameters: parameters, headers: headers ).responseData { (dataResponse) in
                
                if let data = dataResponse.data {
                    //self.ImageView.image = UIImage(data: data)
                    //print(data)
                    if let image = UIImage (data:data) {
                        self.pic4.image = image
                    }
                }
            }
        }
        
        if self.arr.count > 4 {
            label5.text = "Name: \(arr[4].user_firstname) \(String(arr[4].user_lastname.characters.prefix(1))). Points: \(arr[4].point_count)"
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let headers = ["Authorization": "Token \(appDelegate.token)"]
            let parameters = ["user_email": arr[4].user_email]
            
            Alamofire.request("http://138.68.252.198:8000/rideshare/get_profile_photo/", method: .get, parameters: parameters, headers: headers ).responseData { (dataResponse) in
                
                if let data = dataResponse.data {
                    //self.ImageView.image = UIImage(data: data)
                    //print(data)
                    if let image = UIImage (data:data) {
                        self.pic5.image = image
                    }
                }
            }
        }
        
        if self.arr.count > 5 {
            label6.text = "Name: \(arr[5].user_firstname) \(String(arr[5].user_lastname.characters.prefix(1))). Points: \(arr[5].point_count)"
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let headers = ["Authorization": "Token \(appDelegate.token)"]
            let parameters = ["user_email": arr[0].user_email]
            
            Alamofire.request("http://138.68.252.198:8000/rideshare/get_profile_photo/", method: .get, parameters: parameters, headers: headers ).responseData { (dataResponse) in
                
                if let data = dataResponse.data {
                    //self.ImageView.image = UIImage(data: data)
                    //print(data)
                    if let image = UIImage (data:data) {
                        self.pic6.image = image
                    }
                }
            }
        }
        
        if self.arr.count > 6 {
            label7.text = "Name: \(arr[6].user_firstname) \(String(arr[6].user_lastname.characters.prefix(1))). Points: \(arr[6].point_count)"
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let headers = ["Authorization": "Token \(appDelegate.token)"]
            let parameters = ["user_email": arr[6].user_email]
            
            Alamofire.request("http://138.68.252.198:8000/rideshare/get_profile_photo/", method: .get, parameters: parameters, headers: headers ).responseData { (dataResponse) in
                
                if let data = dataResponse.data {
                    //self.ImageView.image = UIImage(data: data)
                    //print(data)
                    if let image = UIImage (data:data) {
                        self.pic7.image = image
                    }
                }
            }
        }
        
        if self.arr.count > 7 {
            label8.text = "Name: \(arr[7].user_firstname) \(String(arr[7].user_lastname.characters.prefix(1))). Points: \(arr[7].point_count)"
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let headers = ["Authorization": "Token \(appDelegate.token)"]
            let parameters = ["user_email": arr[7].user_email]
            
            Alamofire.request("http://138.68.252.198:8000/rideshare/get_profile_photo/", method: .get, parameters: parameters, headers: headers ).responseData { (dataResponse) in
                
                if let data = dataResponse.data {
                    //self.ImageView.image = UIImage(data: data)
                    //print(data)
                    if let image = UIImage (data:data) {
                        self.pic8.image = image
                    }
                }
            }
        }
        
        if self.arr.count > 8 {
            label9.text = "Name: \(arr[8].user_firstname) \(String(arr[8].user_lastname.characters.prefix(1))). Points: \(arr[8].point_count)"
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let headers = ["Authorization": "Token \(appDelegate.token)"]
            let parameters = ["user_email": arr[8].user_email]
            
            Alamofire.request("http://138.68.252.198:8000/rideshare/get_profile_photo/", method: .get, parameters: parameters, headers: headers ).responseData { (dataResponse) in
                
                if let data = dataResponse.data {
                    //self.ImageView.image = UIImage(data: data)
                    //print(data)
                    if let image = UIImage (data:data) {
                        self.pic9.image = image
                    }
                }
            }
        }
        
        if self.arr.count > 9 {
            label10.text = "Name: \(arr[9].user_firstname) \(String(arr[9].user_lastname.characters.prefix(1))). Points: \(arr[9].point_count)"
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let headers = ["Authorization": "Token \(appDelegate.token)"]
            let parameters = ["user_email": arr[9].user_email]
            
            Alamofire.request("http://138.68.252.198:8000/rideshare/get_profile_photo/", method: .get, parameters: parameters, headers: headers ).responseData { (dataResponse) in
                
                if let data = dataResponse.data {
                    //self.ImageView.image = UIImage(data: data)
                    //print(data)
                    if let image = UIImage (data:data) {
                        self.pic10.image = image
                    }
                }
            }
        }
        
    }






}
