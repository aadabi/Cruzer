//
//  userRatingViewController.swift
//  Slug Ride 2
//
//  Created by Andrew dato on 7/13/17.
//  Copyright © 2017 Andrew Dat0. All rights reserved.
//

/*
 The MIT License (MIT)
 
 Copyright (c) 2014 Glen Yi
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

import UIKit
import AVFoundation
import Alamofire
class userRatingViewController: UIViewController, FloatRatingViewDelegate {
    
    //Variables used for the AV functionality
    var avPlayer: AVPlayer!
    var avPlayerLayer: AVPlayerLayer!
    var paused: Bool = false

    
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet var floatRatingView: FloatRatingView!
    
    @IBOutlet weak var videoView: UIView!
    var counter = 0
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        //avPlayer.play()
        //paused = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //avPlayer.pause()
        //paused = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.userName.text = appDelegate.newRatingList[counter].name
        let headers = [
            "Authorization": "Token \(appDelegate.token)"
        ]
        
        let parameters = ["user_email": appDelegate.newRatingList[counter].email]
        
        Alamofire.request("http://138.68.252.198:8000/rideshare/get_profile_photo/", method: .get, parameters: parameters, headers: headers ).responseData { (dataResponse) in
            
            if let data = dataResponse.data {
                //self.ImageView.image = UIImage(data: data)
                //print(data)
                if let image = UIImage (data:data) {
                    self.imageProfile.image = self.round(image: image)
                    
                }
            }
        }
 /*
        if let theURL: NSURL = Bundle.main.url(forResource: "rating", withExtension: "mp4")! as NSURL{
            avPlayer = AVPlayer(url: theURL as URL)
            
        }
        
        
        
       
        //AV player settings
        avPlayerLayer = AVPlayerLayer(player: avPlayer)
        avPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        avPlayer.volume = 0
        avPlayer.actionAtItemEnd = .none
        
        
        avPlayerLayer.frame = self.videoView.bounds
        
        self.videoView.backgroundColor = .clear
        self.videoView.layer.insertSublayer(avPlayerLayer, at: 0)
        //view.layer.insertSublayer(avPlayerLayer, at: 0)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerItemDidReachEnd(notification:)),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: avPlayer.currentItem)
        
        */
        /** Note: With the exception of contentMode, all of these
         properties can be set directly in Interface builder **/

        // Required float rating view params
        view.backgroundColor = UIColor(r: 227, g: 226, b: 191)
        self.floatRatingView.emptyImage = UIImage(named: "StarEmpty")
        self.floatRatingView.fullImage = UIImage(named: "StarFull")
        // Optional params
        self.floatRatingView.delegate = self
        self.floatRatingView.contentMode = UIViewContentMode.scaleAspectFit
        self.floatRatingView.maxRating = 5
        self.floatRatingView.minRating = 1
        self.floatRatingView.rating = 2.5
        self.floatRatingView.editable = true
        self.floatRatingView.halfRatings = true
        self.floatRatingView.floatRatings = false

        
        // Labels init
    
    }
    
    
    @IBAction func submit(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        print("check")
        print(self.floatRatingView.rating)
        let dict = ["user_email":appDelegate.newRatingList[counter].email, "rating": self.floatRatingView.rating] as [String: Any]
        print(dict)
        if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted){
            print("success")
            let url = NSURL(string: "http://138.68.252.198:8000/rideshare/rate_user/")!
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
                guard let data = data else {
                    print("Data Empty")
                    return
                }
                print("success3")
            }
            task.resume()
        }

        counter+=1
        
        if counter == appDelegate.newRatingList.count {
            appDelegate.newRatingList.removeAll()
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
            self.present(newViewController, animated: true, completion: nil)
        } else {
            self.userName.text = appDelegate.newRatingList[counter].name
            let headers = [
                "Authorization": "Token \(appDelegate.token)"
            ]
            
            let parameters = ["user_email": appDelegate.newRatingList[counter].email]
            
            Alamofire.request("http://138.68.252.198:8000/rideshare/get_profile_photo/", method: .get, parameters: parameters, headers: headers ).responseData { (dataResponse) in
                
                if let data = dataResponse.data {
                    //self.ImageView.image = UIImage(data: data)
                    //print(data)
                    if let image = UIImage (data:data) {
                        self.imageProfile.image = image
                    }
                }
            }
        }
    }
    
    func round(image: UIImage) -> UIImage {
        let imageWidth = image.size.width
        let imageHeight = image.size.height
        
        let diameter = min(imageWidth, imageHeight)
        let isLandscape = imageWidth > imageHeight
        
        let xOffset = isLandscape ? (imageWidth - diameter) / 2 : 0
        let yOffset = isLandscape ? 0 : (imageHeight - diameter) / 2
        
        let imageSize = CGSize(width: diameter, height: diameter)
        
        return UIGraphicsImageRenderer(size: imageSize).image { _ in
            
            let ovalPath = UIBezierPath(ovalIn: CGRect(origin: .zero, size: imageSize))
            ovalPath.addClip()
            image.draw(at: CGPoint(x: -xOffset, y: -yOffset))
            UIColor(r: 0, g: 63, b: 14).setStroke()
            ovalPath.lineWidth = diameter / 50
            ovalPath.stroke()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    //Repeat the video at the end
    func playerItemDidReachEnd(notification: Notification) {
        let p: AVPlayerItem = notification.object as! AVPlayerItem
        p.seek(to: kCMTimeZero)
    }*/
    
    // MARK: FloatRatingViewDelegate
    
    func floatRatingView(_ ratingView: FloatRatingView, isUpdating rating:Float) {
        //self.liveLabel.text = NSString(format: "%.2f", self.floatRatingView.rating) as String
    }
    
    func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Float) {
        //self.updatedLabel.text = NSString(format: "%.2f", self.floatRatingView.rating) as String
    }
}
