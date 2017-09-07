//
//  EditInformationViewController.swift
//  Slug Ride 2
//
//  Created by Andrew Dato 
//  Copyright © 2017 Andrew Dat0. All rights reserved.
//


//IMPORTANT!!!
//website for server image upload
//https://newfivefour.com/swift-form-data-multipart-upload-URLRequest.html
//alamofire: https://solarianprogrammer.com/2017/05/02/swift-alamofire-tutorial-uploading-downloading-images/
//!!!!!!!!!!!!!!!!



import Foundation
import UIKit
import SwiftyJSON
import Alamofire
import AVFoundation
class EditInformationViewController : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    

    var avPlayer: AVPlayer!
    var avPlayerLayer: AVPlayerLayer!
    var paused: Bool = false
    
    //image view where image appears once chosen
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    
    //Button to choose image with options
    @IBAction func chooseImage(_ sender: Any) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source",
                                            preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action:UIAlertAction) in
            imagePickerController.sourceType = .camera
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {(action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.allowsEditing = false
            self.present(imagePickerController, animated: true)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]){
        
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imageView.image = image
            
            
            //rounds corners to image
            self.imageView.roundCornersForAspectFit(radius: 5)
        } else{
            print("Something went wrong")
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    ///////////////////////////////////////////////////////////////
    //functions to upload image to server
    ///////////////////////////////////////////////////////////////
    

    //Button to upload image
    @IBAction func uploadImage(_ sender: Any) {
        
        
        //URL must be CHANGED to API
        let imageRequest  = NSMutableURLRequest(url: URL(string: "http://138.68.252.198:8000/rideshare/driver_info_submit/")!)
        
        
        imageRequest.httpMethod = "POST"
        let boundary = "Boundary-\(UUID().uuidString)"
        imageRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
       
        
        
        let imageData = UIImagePNGRepresentation(self.imageView.image!)
       
        
        
        
        
        
        // User "authentication":
             let parameters = ["user_email" : "od1@ucsc.edu", "image_name" : "testimage.jpg"]
        
             // Image to upload:
             let imageToUploadURL = Bundle.main.url(forResource: "tree", withExtension: "png")
        
             // Server address (replace this with the address of your own server):
             let url = "http://138.68.252.198:8000/rideshare/driver_info_submit/"
        
             // Use Alamofire to upload the image
             Alamofire.upload(
                     multipartFormData: { multipartFormData in
                        
                             multipartFormData.append(imageData!, withName: "image")
                             for (key, val) in parameters {
                                     multipartFormData.append(val.data(using: String.Encoding.utf8)!, withName: key)
                                 }
                     },
                     to: url,
                     encodingCompletion: { encodingResult in
                         switch encodingResult {
                         case .success(let upload, _, _):
                             upload.responseJSON { response in
                                 if let jsonResponse = response.result.value as? [String: Any] {
                                     print(jsonResponse)
                                 }
                             }
                         case .failure(let encodingError):
                             print(encodingError)
                         }
                 }
                 )
        
        
               //Alamofire code
        
        
        //create http body with selected image
//        imageRequest.httpBody = createBody(parameters: params,
//                                           boundary: boundary,
//                                           data: UIImageJPEGRepresentation(self.imageView.image!, 0.7)!,
//            mimeType: "image/jpg",
//            filename: "default.jpg"
//            
//            
//        )
    }
    
    @IBAction func back(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        self.present(newViewController, animated: true, completion: nil)
    }
    
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
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        avPlayer.pause()
        paused = true
        
    }

    
    
    //create body for Multipart data upload
    func createBody(parameters: [String: String],
                    boundary: String,
                    data: Data,
                    mimeType: String,
                    filename: String) -> Data {
        let body = NSMutableData()
        
        let boundaryPrefix = "--\(boundary)\r\n"
        
        for (key, value) in parameters {
            body.appendString(boundaryPrefix)
            body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.appendString("\(value)\r\n")
        }
        
        body.appendString(boundaryPrefix)
        body.appendString("Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimeType)\r\n\r\n")
        body.append(data)
        body.appendString("\r\n")
        body.appendString("--".appending(boundary.appending("--")))
        
        return body as Data
        
        
        //print result
        print(body)
        
        
    }
    
    
    
    
}




