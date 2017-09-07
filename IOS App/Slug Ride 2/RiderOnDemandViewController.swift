//
//  RiderOnDemandViewController.swift
//  Slug Ride 2
//
//  Created by Andrew Dati on 4/19/17.
//  Copyright © 2017 Andrew Dat0. All rights reserved.
//

import Foundation
import UIKit

class RiderOnDemandViewController : UIViewController{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
}
