//
//  AdditionalInfoViewController.swift
//  TagRides
//
//  Created by Andrew Dato on 9/28/17.
//  Copyright © 2017 TagRides. All rights reserved.
//

import Foundation
import UIKit

class AdditionalInforViewController: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var desc: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         //let appDelegate = UIApplication.shared.delegate as! AppDelegate
         //self.picture.image = appDelegate.profileImage
         //view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
}
