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

class ChangeLicenseViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func selectPicture(_ sender: AnyObject) {
        
        let ImagePicker = UIImagePickerController()
        ImagePicker.delegate = self
        ImagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(ImagePicker, animated: true, completion: nil)
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        image.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        UploadRequest()
    }
    
    
    
    
    func UploadRequest()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let image = self.image.image
        let imgData = UIImageJPEGRepresentation(image!, 0.2)!
        
        
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
            to:"http://138.68.252.198:8000/rideshare/upload_profile_license/",
            headers: headers,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        debugPrint(response)
                        self.postDone()
                    }
                case .failure(let encodingError):
                    print("encoding Error : \(encodingError)")
                }
        })
        
    }
    
    func postDone() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        self.present(newViewController, animated: true, completion: nil)
    }
    
}
