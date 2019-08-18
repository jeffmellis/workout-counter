//
//  InterfaceController.swift
//  Workout counter WatchKit Extension
//
//  Created by jeff mellis on 2019-08-14.
//  Copyright © 2019 jeff mellis. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    var currentCount: Int = 0
    var isStopped = true
    @IBOutlet var counterButtton: WKInterfaceButton!
    @IBOutlet var timer: WKInterfaceTimer!
    
    
    @IBAction func onTimerClick(_ sender: Any) {
        if (isStopped) {
            onTimerStart()
        } else {
            onTimerStop()
        }
    }
    
    func onTimerStop(textColor: UIColor = UIColor.red) {
        timer.stop()
        timer.setTextColor(textColor)
        isStopped = true
    }
    func onTimerStart(textColor: UIColor = UIColor.green) {
        timer.setDate(Date())
        timer.start()
        timer.setTextColor(textColor)
        isStopped = false
    }

    @IBAction func onIncrementCounter() {
        currentCount += 1
        updateInterface()
    }
    @IBAction func onDecrementCounter() {
        currentCount -= 1
        updateInterface()
    }
    @IBAction func onReset() {
        currentCount = 0
        timer.setDate(Date())
        onTimerStop(textColor: UIColor.white)
        updateInterface()
    }
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func updateInterface() {
        counterButtton.setTitle(String(currentCount))
        
        UserDefaults.standard.set(currentCount, forKey:  "count")
        let complicationServer = CLKComplicationServer.sharedInstance()
        for complication in complicationServer.activeComplications! {
            complicationServer.reloadTimeline(for: complication)
        }
    }
}
