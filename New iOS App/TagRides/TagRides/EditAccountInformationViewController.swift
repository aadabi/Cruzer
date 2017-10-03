//
//  EditAccountInformationViewController.swift
//  TagRides
//
//  Created by Andrew Dato on 9/26/17.
//  Copyright © 2017 TagRides. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class EditAccountInformationViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    //@IBOutlet weak var Password: UITextField!
    //@IBOutlet weak var VeriPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func errorMessage(err :String) {
        let alert = UIAlertController(title: "Edit Information Error", message: err, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title:"Ok",style: UIAlertActionStyle.default, handler:
            {action in
                
                //set timer for polling again because rider was declined
                //self.timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.pollforRequests(_:)), userInfo: nil, repeats: true)
        }
        ))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func Submit(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        var first = ""
        var last = ""
        var pass = ""
        

        
        if let text = firstName.text, !text.isEmpty {
            first = firstName.text!
        }
        
        if let text = lastName.text, !text.isEmpty {
            last = lastName.text!
        }
        /*
        if let text = Password.text, !text.isEmpty {
            if (Password.text == VeriPassword.text) {
                pass = Password.text!
            } else {
                errorMessage(err: "Passwords Do not Match")
            }
        }*/

        
        
        
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
    
    var image = UIImage()
    
    func selectPicture() {
        
        let ImagePicker = UIImagePickerController()
        ImagePicker.delegate = self
        ImagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(ImagePicker, animated: true, completion: nil)
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        image = (info[UIImagePickerControllerOriginalImage] as? UIImage)!
        self.dismiss(animated: true, completion: nil)
        UploadRequest()
    }
    
    
    
    func UploadRequest()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let image = self.image
        let imgData = UIImageJPEGRepresentation(image, 0.2)!
        
        
        // If you have any autorization headers
        let headers = [
            "Authorization": "Token \(appDelegate.token)"
        ]
        print("check")
        let parameters = ["user_email": appDelegate.user_email]
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(imgData, withName: "image",fileName: "image.jpg", mimeType: "image/jpg")
                for (key, value) in parameters {
                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                }
        },
            to:"http://138.68.252.198:8000/rideshare/upload_profile_photo/",
            headers: headers,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        debugPrint(response)
                        self.postDone1()
                    }
                case .failure(let encodingError):
                    print("encoding Error : \(encodingError)")
                }
        })
        
    }
    
    func postDone1() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // If you have any autorization headers
        let headers = [
            "Authorization": "Token \(appDelegate.token)"
        ]
        
        let parameters = ["user_email": appDelegate.user_email]
        
        Alamofire.request("http://138.68.252.198:8000/rideshare/get_profile_photo/", method: .get, parameters: parameters, headers: headers ).responseData { (dataResponse) in
            
            if let data = dataResponse.data {
                //self.ImageView.image = UIImage(data: data)
                //print(data)
                if let image = UIImage (data:data) {
                    appDelegate.profileImage = UIImage(data: data)!
                }
            }
        }
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        self.present(newViewController, animated: true, completion: nil)
    }
    
    
    @IBAction func Upload(_ sender: Any) {
        selectPicture()
    }
}
