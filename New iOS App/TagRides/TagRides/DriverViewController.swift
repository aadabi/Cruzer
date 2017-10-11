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
import SwiftKeychainWrapper
import Alamofire

class DriverViewController: UIViewController {

    @IBOutlet weak var SlideMenu: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if (appDelegate.start == false) {
            KeychainWrapper.standard.set(appDelegate.user_email, forKey: "TagRidesUsername")
            KeychainWrapper.standard.set(appDelegate.user_pass, forKey: "TagRidesPassword")
            appDelegate.start = true

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
            
        }

        view.backgroundColor = UIColor(r: 227, g: 226, b: 191)
        self.tabBarController!.tabBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = false
        if revealViewController() != nil {
            revealViewController().rearViewRevealWidth = 250
            SlideMenu.target = revealViewController()
            SlideMenu.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            print("pass")
        } else {
            print("fail")
        }

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Function for when it loads up the second time
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController!.tabBar.isHidden = true
    }
    
    //Function for when you leave the page
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    //Status bar color
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func DriverMove(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if (appDelegate.driver_approval == true) {
            appDelegate.driver_status = true;
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "TransitionViewController") as! TransitionViewController
            self.present(newViewController, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Driver Not Approved", message: "Please go to Add Driver Info and send us a picture of your driver license for approval", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title:"Ok",style: UIAlertActionStyle.default, handler:
                {action in
            }
            ))
            self.present(alert, animated: true, completion: nil)
        }

        
    }
    
    @IBAction func RiderMover(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.driver_status = false;
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "TransitionViewController") as! TransitionViewController
        self.present(newViewController, animated: true, completion: nil)
    }
}
