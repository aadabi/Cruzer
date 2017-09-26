//
//  tabViewController.swift
//  Slug Ride 2
//
//  Created by Braulio De La Torre on 6/6/17.
//  Copyright © 2017 Andrew Dat0. All rights reserved.
//

import UIKit

class tabViewController: UITabBarController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Sets the default color of the icon of the selected UITabBarItem and Title
        UITabBar.appearance().tintColor = UIColor.red
        
        // Sets the default color of the background of the UITabBar
        UITabBar.appearance().barTintColor = UIColor.purple
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
