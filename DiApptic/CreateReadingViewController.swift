//
//  AddReadingViewController.swift
//  DiApptic
//
//  Created by Faheem Hussain on 11/14/16.
//  Copyright © 2016 Faheem Hussain. All rights reserved.
//

import UIKit
import Parse
import Toaster

protocol CreateReadingDelegate: class {
    func onSaveReading(reading: Reading?)
}
class CreateReadingViewController: UIViewController {
    
    weak var saveDelegate: CreateReadingDelegate?
    
    @IBOutlet weak var circularSlider: CircleSliderView!
    @IBOutlet weak var fastingButton: RoundButton!
    @IBOutlet weak var beforeMealButton: RoundButton!
    @IBOutlet weak var afterMealButton: RoundButton!
    var statusButtons: [RoundButton] = []
    
    @IBOutlet weak var insulinButton: RoundButton!
    @IBOutlet weak var oralButton: RoundButton!
    @IBOutlet weak var notesField: UITextView!
    var medicationButtons: [RoundButton] = []
    
    var status: String?
    var medicationType: String?
    var notes: String?
    var recordingValue: Int? = 42
    var loadingUtils = LoadingIndicatorUtils();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        statusButtons = [fastingButton, beforeMealButton, afterMealButton]
        medicationButtons = [insulinButton, oralButton]
        let saveBarButtonItem = UIBarButtonItem(image: UIImage(named:"save24x24") , style: UIBarButtonItemStyle.plain, target: self, action: #selector(CreateReadingViewController.onSave))
        self.navigationItem.rightBarButtonItem  = saveBarButtonItem
        notesField.layer.borderWidth = 0.5
        notesField.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createReading() {
        let reading = PFObject(className:"Recording")
        recordingValue = circularSlider.onValueChanged()
        reading["user"] = PFUser.current()
        reading["recordingValue"] = recordingValue
        reading["medicationType"] = medicationType
        reading["status"] = status
        reading["notes"] = notesField.text
        Reading.add(reading: Reading(timestamp: Date(), status: Status(rawValue: status!)!, medication: Medication(rawValue: medicationType!)!, value: recordingValue!, note: notesField.text))
        reading.saveInBackground { (saved:Bool, error:Error?) -> Void in
            if saved {
                print("saved worked")
                self.loadingUtils.hideActivityIndicator(uiView: self.view)
                Toast(text: "Saved Reading").show()
                self.saveDelegate?.onSaveReading(reading: nil)
            } else {
                print(error)
                Toast(text: "Error").show()
            }
        }
    }
    
    @IBAction func statusTap(_ sender: RoundButton) {
        //for button in statusButtons {
            if sender == fastingButton {
                if(sender.isSelected) {
                    sender.isSelected = false
                    status = ""
                }else {
                     sender.isSelected = true
                     afterMealButton.isSelected = false
                     beforeMealButton.isSelected = false
                     status = "Fasting"
                }
        } else if sender == beforeMealButton {
                if(sender.isSelected) {
                    sender.isSelected = false
                    status = ""
                }else {
                    sender.isSelected = true
                    afterMealButton.isSelected = false
                    fastingButton.isSelected = false
                    status = "Before Meal"
                }
            } else if sender == afterMealButton {
                if(sender.isSelected) {
                    sender.isSelected = false
                    status = ""
                }else {
                    sender.isSelected = true
                    fastingButton.isSelected = false
                    beforeMealButton.isSelected = false
                    status = "After Meal"
                }
            }
    }
    
    @IBAction func medicationTap(_ sender: RoundButton) {
            if sender == insulinButton {
                if(sender.isSelected) {
                    sender.isSelected = false
                    medicationType = ""
                }else {
                    sender.isSelected = true
                    oralButton.isSelected = false
                    medicationType = "Insulin"
                }
            } else if sender ==  oralButton{
                if(sender.isSelected) {
                    sender.isSelected = false
                    medicationType = ""
                }else {
                    sender.isSelected = true
                    insulinButton.isSelected = false
                    medicationType = "Oral"
                }
            }
    }
    
    func onSave() {
        loadingUtils.showActivityIndicator(uiView: self.view)
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
