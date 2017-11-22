//
//  SlideMenuViewController.swift
//  TagRides
//
//  Created by Andrew Dato on 9/25/17.
//  Copyright © 2017 TagRides. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import ChatSDKCore
import ChatSDKUI
import ChatSDKCoreData
import SafariServices
import SwiftKeychainWrapper
import MessageUI

class SlideMenuViewController : UITableViewController, MFMailComposeViewControllerDelegate {
    var window: UIWindow?
    var test : UIButton = UIButton()
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Points: UILabel!
    @IBOutlet weak var DriverRating: UILabel!
    @IBOutlet weak var RiderRating: UILabel!
    @IBOutlet weak var DriverStatus: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController!.tabBar.isHidden = true
        view.backgroundColor = UIColor(r: 227, g: 226, b: 191)
        
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.imgProfile.image = self.round(image: appDelegate.profileImage)
        self.Name.text = "\(appDelegate.user_firstname) \(appDelegate.user_lastname)"
        if appDelegate.driver_approval == false {
            self.DriverStatus.text = "Driver: Not Approved"
        } else {
            self.DriverStatus.text = "Driver: Approved"
        }
        self.Points.text = "Total Points: \(appDelegate.point_count)"
        //view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        getDriver()
    }
    
    func getDriver () {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let dict = ["user_email":appDelegate.user_email] as [String: Any]
        //let dict = ["user_email":appDelegate.user_email, "first_name":"Test", "last_name":"Test", "user_car":"Test", "car_color":"Test", "car_capacity":5] as [String: Any]
        print(dict)
        if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted){
            print("success")
            let url = NSURL(string: "http://138.68.252.198:8000/rideshare/account_info/")!
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
                let json = JSON(data: data)
                self.dRating = json["driver_rating"].double!
                self.rRating = json["rider_rating"].double!
                DispatchQueue.main.async(execute: self.loadDone)
            }
            task.resume()
        }
    }

    var dRating : Double = 0
    var rRating : Double = 0
    func loadDone() {
        self.DriverRating.text = "Driver Rating: \(dRating)"
        self.RiderRating.text = "Rider Rating: \(rRating)"
        
    }

    @IBAction func ChatButton(_ sender: Any) {
        //BInterfaceManager.shared().a = BDefaultInterfaceAdapter.init()
        //BNetworkManager.shared().a = BFirebaseNetworkAdapter.init()
        //BStorageManager.shared().a = BCoreDataManager.init()
        
        let mainViewController = BAppTabBarController.init(nibName: nil, bundle: nil)
        BNetworkManager.shared().a.auth().setChallenge(BLoginViewController.init(nibName: nil, bundle: nil));
        //self.navigationController?.pushViewController(mainViewController, animated: true)

        test = UIButton(frame: CGRect(x: 0, y: 65, width: 75, height: 25))
        //test.backgroundColor = .green
        test.backgroundColor = .white
        test.layer.cornerRadius = 10
        test.layer.backgroundColor = UIColor(r: 0, g: 63, b: 14).cgColor
        test.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        test.setTitleColor(UIColor.white, for: .normal)
        test.setTitle("Exit", for: .normal)
        //revealViewController().rearViewRevealWidth = 250
        test.addTarget(self, action: #selector(ButtonPressed), for: .touchUpInside)
        
        //if revealViewController() != nil {

        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.rootViewController = mainViewController;
        self.window?.makeKeyAndVisible();
        //self.window?.hide
        self.window?.addSubview(test)
        
    }
    @IBAction func ReportPressed(_ sender: Any) {
        if !MFMailComposeViewController.canSendMail() {
            print("Mail services are not available")
            return
        }
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        // Configure the fields of the interface.
        composeVC.setToRecipients(["help@tagrides.com"])
        composeVC.setSubject("Report")
        composeVC.setMessageBody("Dear TagRides, ", isHTML: false)
        // Present the view controller modally.
        self.present(composeVC, animated: true, completion: nil)
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult, error: Error?) {
        // Check the result or perform other tasks.
        
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
    }
    
    func ButtonPressed(sender: UIButton!) {
        self.window?.isHidden = true
        //let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        //let newViewController = storyBoard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        //self.present(newViewController, animated: true, completion: nil)
    }
    
    /*
    func sendEmail() {
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        // Configure the fields of the interface.
        composeVC.setToRecipients(["address@example.com"])
        composeVC.setSubject("Hello!")
        composeVC.setMessageBody("Hello this is my message body!", isHTML: false)
        // Present the view controller modally.
        self.present(composeVC, animated: true, completion: nil)
    }
    
    func mailComposeController(controller: MFMailComposeViewController,
                               didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        // Check the result or perform other tasks.
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
    }*/
    
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

    @IBAction func ContactUsButton(_ sender: Any) {
        let svc = SFSafariViewController(url: URL(string:"http://tagrides.com/")!)
        self.present(svc, animated: true, completion: nil)
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        KeychainWrapper.standard.removeObject(forKey: "TagRidesUsername")
        KeychainWrapper.standard.removeObject(forKey: "TagRidesPassword")
        appDelegate.start = false
    }
}
