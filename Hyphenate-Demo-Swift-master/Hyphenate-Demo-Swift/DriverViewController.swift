//
//  DriverViewController.swift
//  Hyphenate-Demo-Swift
//
//  Created by Andrew Dato on 9/17/17.
//  Copyright © 2017 杜洁鹏. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class DriverViewController: UIViewController {
    //Basic function that runs when the page first loads up
    override func viewDidLoad() {
        super.viewDidLoad()
        let backButton = UIBarButtonItem(title: "< Logout", style: UIBarButtonItemStyle.plain, target: self, action: #selector(DriverViewController.backButtonAction(_:)))
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationController?.isNavigationBarHidden = false
        //self.navigationController?.isNavigationBarHidden = true
    }
    
    func backButtonAction(_ button: UIBarButtonItem) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Launch", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.present(newViewController, animated: true, completion: nil)
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
