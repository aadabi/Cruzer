//
//  QRViewerViewController.swift
//  Slug Ride 2
//
//  Created by Andrew dato on 7/5/17.
//  Copyright © 2017 Andrew Dat0. All rights reserved.
//
import Foundation
import UIKit

class QRViewerViewController : UIViewController{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
}

