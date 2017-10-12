//
//  AppDelegate.swift
//  TagRides
//
//  Created by Andrew Dato on 9/25/17.
//  Copyright © 2017 TagRides. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import ChatSDKCore
import ChatSDKUI
import ChatSDKCoreData


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var start = false 
    var window: UIWindow?
    var user_email:String = "temp" //Global Variable for User Email Addresssaadd
    var user_firstname:String = "temp" //Global Variable for User First Name
    var user_lastname:String = "temp" //Global Variable for Usedr Last Name
    var user_pass: String = "temp" //Global Variable for User Password
    var driver_status = true
    var driver_approval = false
    var point_count = 100;
    var ratingList = [String]()
    var token = ""
    var profileImage = UIImage()
    var newRatingList = [getImage]()
    var rider_email = ""
    var rider_name = ""
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.sharedManager().enable = true
        BInterfaceManager.shared().a = BDefaultInterfaceAdapter.init()
        BNetworkManager.shared().a = BFirebaseNetworkAdapter.init()
        BStorageManager.shared().a = BCoreDataManager.init()
        BFirebaseSocialLoginModule.init().activate(with: application, withOptions: launchOptions)
        /*
        //Chat SDK
        BInterfaceManager.shared().a = BDefaultInterfaceAdapter.init()
        BNetworkManager.shared().a = BFirebaseNetworkAdapter.init()
        BStorageManager.shared().a = BCoreDataManager.init()
 
        let mainViewController = BAppTabBarController.init(nibName: nil, bundle: nil)
        BNetworkManager.shared().a.auth().setChallenge(BLoginViewController.init(nibName: nil, bundle: nil));
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.rootViewController = mainViewController;
        self.window?.makeKeyAndVisible();
         */
        
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        if(BNetworkManager.shared().a.socialLogin() != nil) {
            return BNetworkManager.shared().a.socialLogin().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
        }
        return false
    }

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask(rawValue: UIInterfaceOrientationMask.portrait.rawValue)
    }

}

