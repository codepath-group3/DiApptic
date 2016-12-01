//
//  AddReadingViewController.swift
//  DiApptic
//
//  Created by Faheem Hussain on 11/14/16.
//  Copyright © 2016 Faheem Hussain. All rights reserved.
//

import UIKit
import CircleSlider
import Parse

class CreateReadingViewController: UIViewController {
    
    @IBOutlet weak var fastingButton: RoundButton!
    @IBOutlet weak var beforeMealButton: RoundButton!
    @IBOutlet weak var afterMealButton: RoundButton!
    var statusButtons: [RoundButton] = []
    
    @IBOutlet weak var insulinButton: RoundButton!
    @IBOutlet weak var oralButton: RoundButton!
    var medicationButtons: [RoundButton] = []
    
    var context: String?
    var medicationType: Int?
    var physicalActivity: String?
    var notes: String?
    var carbsIntake: Int?
    var readingValue: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusButtons = [fastingButton, beforeMealButton, afterMealButton]
        medicationButtons = [insulinButton, oralButton]
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func createReading() {
        var reading = PFObject(className:"Reading")
        reading["value"] = readingValue
        reading["medicationType"] = medicationType
        reading["carbsTaken"] = carbsIntake
        reading["physicalActivity"] = physicalActivity
        reading["context"] = context
        //reading["note"] = notesField.text
        reading.saveInBackground { (saved:Bool, error:Error?) -> Void in
            if saved {
                print("saved worked")
            } else {
                print(error)
            }
        }
    }
    @IBAction func statusTap(_ sender: RoundButton) {
        for button in statusButtons {
            if button == sender {
                button.isSelected = true
            }else {
                button.isSelected = false
            }
        }
    }
    
    @IBAction func medicationTap(_ sender: RoundButton) {
        for button in medicationButtons {
            if button == sender {
                button.isSelected = true
            }else {
                button.isSelected = false
            }
        }
    }
    
    @IBAction func onSave(_ sender: Any) {
        createReading()
    }
    @IBAction func onTapButton(_ sender: RoundButton) {
        sender.isSelected = !sender.isSelected
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
