//
//  ViewController.swift
//  BGSProgressMonitor
//
//  Created by Peter Todd on 06/20/2016.
//  Copyright (c) 2016 Peter Todd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let notificationProgress = "com.brightbluecircle.circleViewProgress"
    
    var timer = NSTimer()
    var secondsLeft = 10.00
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func displayButAction(sender: AnyObject) {
        
        displayPM("DEMO")
        self.startDemoJob()
        
        
        
        /*
         // Run demo calls to update Progress Momnitor on a new thread
         let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
         dispatch_async(dispatch_get_global_queue(priority, 0)) {
         self.startDemoJob()
         //    self.startStep1()
         
         //    self.progressUIDemo()
         }
         
         // Run a test to show update of progress
         //displaySyncDemo()
         */
        
    }
    
    private func displayPM(jobTitle : String?){
        if let topVC = UIApplication.topViewController(){
            let displayVC = BLAMProgressMonitorVC()
            if jobTitle != nil{
                displayVC.jobLabel = jobTitle
            }
            let transitionManager = BGSTransitionCenteredModal()
            displayVC.transitioningDelegate = transitionManager
            topVC.presentViewController(displayVC, animated: true, completion: nil)
            
        }
    }

    
    // MARK: - DEMO
    // A 4 step :
    // Connect to Server
    // If a User image present return a blob key from data store
    // Upload a user record to create user on server
    // Process callback from server to update the local user record with server keys
    // (Async) upload the user image
    
    func startDemoJob(){
        var dataDict = Dictionary<String, AnyObject>()
        dataDict["stepDict"] = stepDict("DEMO Connect", status: "Started", stepDesc: "This is the first step", stepID: "0001")
        dispatch_async(dispatch_get_main_queue()) {
            NSNotificationCenter.defaultCenter().postNotificationName(self.notificationProgress, object:self , userInfo: dataDict)
        }
        // Start Connect
        let connectDemoTime = 3.00
        NSTimer.scheduledTimerWithTimeInterval(connectDemoTime, target:self, selector: #selector(connectComplete), userInfo: nil, repeats: false)
        
    }
    
    func connectComplete() {
        var dataDict = Dictionary<String, AnyObject>()
        dataDict["stepDict"] = self.stepDict("DEMO Connect", status: "Success", stepDesc: "This is the first step", stepID: "0001")
        let floatPercent : Double = 5.00 / 100
        dataDict["percent"] = NSNumber(double: floatPercent)
        
        dispatch_async(dispatch_get_main_queue()) {
            NSNotificationCenter.defaultCenter().postNotificationName(self.notificationProgress, object:self , userInfo: dataDict)
        }
        
        var dataDict2 = Dictionary<String, AnyObject>()
        dataDict2["stepDict"] = stepDict("DEMO User Profile", status: "Started", stepDesc: "This is the second step", stepID: "0002")
        dispatch_async(dispatch_get_main_queue()) {
            NSNotificationCenter.defaultCenter().postNotificationName(self.notificationProgress, object:self , userInfo: dataDict2)
        }
        // Start User Profile upload DEMO
        let connectDemoTime = 3.00
        NSTimer.scheduledTimerWithTimeInterval(connectDemoTime, target:self, selector: #selector(userUploadComplete), userInfo: nil, repeats: false)
        
        
    }
    
    func userUploadComplete() {
        var dataDict = Dictionary<String, AnyObject>()
        dataDict["stepDict"] = self.stepDict("DEMO User Profile", status: "Success", stepDesc: "This is the second step", stepID: "0002")
        let floatPercent : Double = 15.00 / 100
        dataDict["percent"] = NSNumber(double: floatPercent)
        
        dispatch_async(dispatch_get_main_queue()) {
            NSNotificationCenter.defaultCenter().postNotificationName(self.notificationProgress, object:self , userInfo: dataDict)
        }
        
        
    }
    
    
    
    
    private func progressUIDemo(){
        // Set the speed of the demo
        let date = NSDate()
        var timestamp = UInt64(floor(date.timeIntervalSince1970 * 1000))
        let delayMicroSec: UInt64 = 10000000
        
        var dataDict = Dictionary<String, AnyObject>()
        
        for i in 0 ..< 101 { // 0 to 100 percent
            // Lets loop some time
            let newTimeStamp = timestamp + delayMicroSec
            while timestamp < newTimeStamp {
                // Hang around a bit - its a Demo!!
                timestamp = timestamp + UInt64(1)
            }
            timestamp = UInt64(floor(date.timeIntervalSince1970 * 1000))
            let floatPercent = Float(i) / 100
            dataDict["percent"] = NSNumber(float: floatPercent)
            print("DEBUG complete: \(i) ")
            // Dispath notification on main thread
            dispatch_async(dispatch_get_main_queue()) {
                NSNotificationCenter.defaultCenter().postNotificationName(self.notificationProgress, object:self , userInfo: dataDict)
            }
            
            
            
            
        }
        
    }
    
    private func startStep1(){
        var dataDict = Dictionary<String, AnyObject>()
        dataDict["stepDict"] = stepDict("Started Test Step 1", status: "Started", stepDesc: "This is the first step", stepID: "0001")
        dispatch_async(dispatch_get_main_queue()) {
            NSNotificationCenter.defaultCenter().postNotificationName(self.notificationProgress, object:self , userInfo: dataDict)
        }
    }
    
    private func stepDict(message : String?, status : String?, stepDesc : String?, stepID : String?)-> Dictionary<String, AnyObject> {
        var dict = [String: AnyObject] ()
        if message != nil{
            dict["message"] = message
        }
        
        if status != nil{
            dict["status"] = status
        }
        
        if stepDesc != nil{
            dict["stepDesc"] = stepDesc
        }
        
        if stepID != nil{
            dict["stepID"] = stepID
        }
        return dict
    }
    


}

