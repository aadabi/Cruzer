//
//  ArityViewController.swift
//  Hyphenate-Demo-Swift
//
//  Created by Andrew Dato on 9/17/17.
//  Copyright © 2017 杜洁鹏. All rights reserved.
//

import Foundation
import UIKit
import CoreEngine

class ArityViewController : UIViewController, DEMDrivingEngineDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // register the view controller as a listener
        registerDriveEventListener()
        
        // configure Driving Engine
        configureDrivingEngine()
        
        let sharedEngine = DEMDrivingEngineManager.sharedManager() as! DEMDrivingEngineManager
        sharedEngine.startEngine()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func registerDriveEventListener() {
        let sharedEngine  = DEMDrivingEngineManager.sharedManager() as! DEMDrivingEngineManager
        
        // set this view controller as the listener for all driving events
        sharedEngine.delegate = self
        
        // listen to all driving events available
        sharedEngine.register(for: DEMEventCaptureMask.all)
    }
    
    func configureDrivingEngine() {
        let driveEngine = DEMDrivingEngineManager.sharedManager() as! DEMDrivingEngineManager
        
        // insert configuration here
        let config = DEMConfiguration.sharedManager() as DEMConfiguration
        config.enableWebServices = false
        config.speedLimit = 40
        
        driveEngine.setConfiguration(config)
        driveEngine.startEngine()
    }
    
    func didStartTripRecording(_ drivingEngine: DEMDrivingEngineManager!) -> String! {
        print("Trip Recording Started")
        return ""
    }
    
    func didStartTripRecording(with tripInfo: DEMTripInfo!) {
        print("Trip Recording Started - Initial Draft")
    }
    
    func drivingEngine(_ drivingEngine: DEMDrivingEngineManager!, didSaveTripInformation trip: DEMTripInfo!, driveStatus driveCompletionFlag: Bool) {
        print("Trip Saved")
    }
    
    func didStopTripRecording(_ drivingEngine: DEMDrivingEngineManager!) {
        print("Trip Recording Stopped")
    }
    
    func didStopInvalidTripRecording(_ drivingEngine: DEMDrivingEngineManager!) {
        print("Trip Recording Stopped - Invalid Trip")
    }
    
    func drivingEngine(_ drivingEngine: DEMDrivingEngineManager!, didDetectAcceleration accelerationEvent: DEMEventInfo!) {
        print("Acceleration Detected")
    }
    
    func drivingEngine(_ drivingEngine: DEMDrivingEngineManager!, didDetectBraking brakingEvent: DEMEventInfo!) {
        print("Braking Detected")
    }
    
    func drivingEngine(_ drivingEngine: DEMDrivingEngineManager!, didDetectStartOfSpeeding overSpeedingEvent: DEMEventInfo!) {
        print("Started Speeding Detected")
    }
    
    func drivingEngine(_ drivingEngine: DEMDrivingEngineManager!, didDetectEndOfSpeeding overSpeedingEvent: DEMEventInfo!) {
        print("Stopped Speeding Detected")
    }
    
    func drivingEngine(_ drivingEngine: DEMDrivingEngineManager!, didErrorOccur errorInfo: DEMError!) {
        print("Drive Error Detected")
    }
}
