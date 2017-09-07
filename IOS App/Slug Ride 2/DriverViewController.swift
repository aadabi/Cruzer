//
//  DriverViewController.swift
//  Slug Ride 2
//
//  Created by Braulio De La Torre on 5/22/17.
//  Copyright © 2017 Andrew Dat0. All rights reserved.
//
//Driver Main Menu Page

import UIKit
import AVFoundation

class DriverViewController: UIViewController {
    
    //Variables used for the AV functionality
    //var avPlayer: AVPlayer!
    //var avPlayerLayer: AVPlayerLayer!
    //var paused: Bool = false

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var coins: UILabel!
    //Link to the video view of the object
    @IBOutlet weak var videoView: UIView!
    
    @IBOutlet weak var appleMapsButton: UIButton!
    //Basic function that runs when the page first loads up
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(r: 227, g: 226, b: 191)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.name.text = appDelegate.user_firstname + " " + appDelegate.user_lastname
        self.coins.text = "\(appDelegate.point_count)"
        //Insert the video for the background
        /*if let theURL: NSURL = Bundle.main.url(forResource: "drivervidfin", withExtension: "mp4")! as NSURL{
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
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerItemDidReachEnd(notification:)),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: avPlayer.currentItem)
        
         //Hide the Navi Bar*/
        //view.layer.insertSublayer(avPlayerLayer, at: 0)
        
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Repeat the video at the end
    func playerItemDidReachEnd(notification: Notification) {
        let p: AVPlayerItem = notification.object as! AVPlayerItem
        p.seek(to: kCMTimeZero)
    }
    
    //Function for when it loads up the second time
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
        //avPlayer.play()
        //paused = false
    }
    
    //Function for when you leave the page
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //avPlayer.pause()
        //paused = true
    }
    
    //Status bar color
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //Move to another page
    @IBAction func CoinMove(_ sender: Any) {
        let newViewController = MarketViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    @IBAction func SettingMove(_ sender: Any) {
        let newViewController = AccountInformationViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    @IBAction func DriverMove(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.driver_status = true;
    }
    
    @IBAction func RiderMover(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.driver_status = false;
    }
    
    @IBAction func test(_ sender: Any) {
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
   
        let dict2 = ["user_email":appDelegate.user_email] as [String: Any]
        //let dict = ["user_email":appDelegate.user_email, "first_name":"Test", "last_name":"Test", "user_car":"Test", "car_color":"Test", "car_capacity":5] as [String: Any]
        print(dict2)
        if let jsonData = try? JSONSerialization.data(withJSONObject: dict2, options: .prettyPrinted){
            print("success")
            let url = NSURL(string: "http://138.68.252.198:8000/rideshare/goal_info/")!
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "POST"
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
                let json = try! JSONSerialization.jsonObject(with: data, options: []) as AnyObject
                print(json)
            }
            task.resume()
        }
    }
    
}
