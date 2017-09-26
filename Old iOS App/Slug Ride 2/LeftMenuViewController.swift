//
//  LeftMenuViewController.swift
//  Slug Ride 2
//
//  Created by Andrew Dato on 9/24/17.
//  Copyright © 2017 Andrew Dat0. All rights reserved.
//

import Foundation
import UIKit

class LeftMenuViewController : UINavigationController{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        view.backgroundColor = UIColor(r: 227, g: 226, b: 191)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        view.backgroundColor = UIColor(r: 227, g: 226, b: 191)
    }
    
}
