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
import SlideMenuControllerSwift

class DriverViewController: UIViewController {
    
    //Variables used for the AV functionality
    //var avPlayer: AVPlayer!
    //var avPlayerLayer: AVPlayerLayer!
    //var paused: Bool = false

    //@IBOutlet weak var name: UILabel!
    //@IBOutlet weak var coins: UILabel!
    //Link to the video view of the object
    //@IBOutlet weak var videoView: UIView!
    
    //@IBOutlet weak var appleMapsButton: UIButton!
    //Basic function that runs when the page first loads up
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(r: 227, g: 226, b: 191)
        //let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //self.name.text = appDelegate.user_firstname + " " + appDelegate.user_lastname
        //self.coins.text = "\(appDelegate.point_count)"
        
        //let rvc = self.storyboard?.instantiateViewController(withIdentifier: "LeftMenuViewController") as! LeftMenuViewController
        //self.slideMenuController()?.leftViewController = rvc
        //self.slideMenuController()?.addLeftGestures()
        
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    @IBAction func DriverMove(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.driver_status = true;
    }
    
    @IBAction func RiderMover(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.driver_status = false;
    }
}
