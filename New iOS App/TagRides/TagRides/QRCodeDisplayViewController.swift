//
//  QRCodeDisplayViewController.swift
//  TagRides
//
//  Created by Andrew Dato on 9/25/17.
//  Copyright © 2017 TagRides. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
class QRCodeDisplayViewController : UIViewController{
    
    
    @IBOutlet weak var Code: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let image = generateQrImage(from: appDelegate.user_email)
        self.Code.image = image
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    //////////////////////////////
    //QR Code Generator Stuff
    //////////////////////////////
    func generateQrImage(from text: String) -> UIImage?{
        let data = text.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator"){
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y:3)
            if let output = filter.outputImage?.applying(transform){
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
    
}
