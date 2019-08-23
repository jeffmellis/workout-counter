//
//  WorkoutController.swift
//  Workout counter WatchKit Extension
//
//  Created by jeff mellis on 2019-08-20.
//  Copyright © 2019 jeff mellis. All rights reserved.
//

import WatchKit
import Foundation

// TODO set the rep and weight value with the dial
// TODO set the picker value via info from userDefaults
// TODO store something in userDefaults when doneSet is clicked
// https://stackoverflow.com/questions/28628225/how-to-save-local-data-in-a-swift-app
// https://stackoverflow.com/questions/29986957/save-custom-objects-into-nsuserdefaults
// https://stackoverflow.com/questions/42204781/did-apple-change-nsuserdefaults-sharing-from-ios-app-to-watchos-app
class WorkoutController: WKInterfaceController, WKCrownDelegate {
    
    @IBOutlet var exercisepicker: WKInterfacePicker!
    @IBOutlet var repButton: WKInterfaceButton!
    @IBOutlet var weightButton: WKInterfaceButton!
    @IBOutlet var doneSetButton: WKInterfaceButton!
    
    var weightButtonValue = 0.0
    var repButtonValue = 0.0
    
    var selectedButton: WKInterfaceButton!
    let selectedButtonColor = UIColor(red: 27/255, green: 82/255, blue: 232/255, alpha: 1.0)
    
    func updateLabels(){
    repButton.setTitle(String(format:"R: %1.0f", repButtonValue))
    weightButton.setTitle(String(format:"W: %1.0f", weightButtonValue))
    }
    
    func crownDidRotate(_ crownSequencer: WKCrownSequencer?, rotationalDelta: Double) {
        if (selectedButton == weightButton) {
            weightButtonValue += rotationalDelta * 30.0
        } else if (selectedButton == repButton) {
            repButtonValue += rotationalDelta * 15.0
        }
        updateLabels()
    }
    
    @IBAction func onWeightButtonClick() {
        if (selectedButton == weightButton) {
            crownSequencer.resignFocus()
            selectedButton = nil
            weightButton.setBackgroundColor(nil)
        } else {
            crownSequencer.focus()
            selectedButton = weightButton
            weightButton.setBackgroundColor(selectedButtonColor)
            repButton.setBackgroundColor(nil)
        }
    }
    
    @IBAction func onRepButtonClick() {
        if (selectedButton == repButton) {
            crownSequencer.resignFocus()
            selectedButton = nil
            repButton.setBackgroundColor(nil)
        } else {
            crownSequencer.focus()
            selectedButton = repButton
            repButton.setBackgroundColor(selectedButtonColor)
            weightButton.setBackgroundColor(nil)
        }
    }
    
    @IBAction func onDoneSetButtonClick() {
        print("done set! write it to the workout!")
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        crownSequencer.delegate = self
    }
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        var exerciseItems: [WKPickerItem] = []
        let exercises = ["Excerise 1", "Excerise 2", "Excerise 3"]
        for exercise in exercises {
            let item = WKPickerItem()
            item.title = exercise
            exerciseItems.append(item)
        }
        exercisepicker.setItems(exerciseItems)
        
        updateLabels()
    }
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
}
