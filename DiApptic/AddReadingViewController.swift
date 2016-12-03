//
//  AddReadingViewController.swift
//  DiApptic
//
//  Created by Faheem Hussain on 11/14/16.
//  Copyright © 2016 Faheem Hussain. All rights reserved.
//

import UIKit
import Parse

class AddReadingViewController: UIViewController {

  
    @IBOutlet weak var readingSliderArea: UIView!
    @IBOutlet weak var breakfastButton: UIButton!
    @IBOutlet weak var lunchButton: UIButton!
    @IBOutlet weak var dinnerButton: UIButton!
    @IBOutlet weak var carbsSlider: UISlider!
    @IBOutlet weak var injectionButton: UIButton!
    @IBOutlet weak var pillButton: UIButton!
    @IBOutlet weak var notesField: UITextField!
    
    var context: String?
    var medicationType: Int?
    var physicalActivity: String?
    var notes: String?
    var carbsIntake: Int?
    var readingValue: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCircularBorder(x: 50, y : 200, button: breakfastButton)
        addCircularBorder(x: 150, y : 200,button: lunchButton)
        addCircularBorder(x: 250, y : 200,button: dinnerButton)
        addCircularBorder(x: 50, y : 300,button: injectionButton)
        addCircularBorder(x: 250, y : 300,button: pillButton)
    }
    
    func addCircularBorder(x: Int, y: Int, button: UIButton) {
        button.backgroundColor = .clear
        button.frame = CGRect(x: x, y: y, width: 60, height: 60)
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.clipsToBounds = true
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.gray.cgColor

    }
    
    @IBAction func onCarbsSliderSelected(_ sender: UISlider) {
        var currentValue = Int(sender.value)
        print("Slider changing to \(currentValue) ?")
        carbsIntake = currentValue
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onBreakfastSelected(_ sender: UIButton) {
        context = "Breakfast"
        print("Breakfast selected")
        breakfastButton.tintColor = UIColor.cyan
        lunchButton.tintColor = UIColor.gray
        dinnerButton.tintColor = UIColor.gray
    }
    
    @IBAction func onLunchSelected(_ sender: UIButton) {
        context = "Lunch"
        print("Lunch selected")
        lunchButton.tintColor = UIColor.cyan
        breakfastButton.tintColor = UIColor.gray
        dinnerButton.tintColor = UIColor.gray
    }
    
    @IBAction func onDinnerSelected(_ sender: UIButton) {
        context = "Dinner"
        print("Dinner selected")
        dinnerButton.tintColor = UIColor.cyan
        lunchButton.tintColor = UIColor.gray
        breakfastButton.tintColor = UIColor.gray
    }

    @IBAction func onInjectionSelected(_ sender: Any) {
        medicationType = 1
        print("Injection selected")
        injectionButton.tintColor = UIColor.cyan
        pillButton.tintColor = UIColor.gray
    }
    
    @IBAction func onPillSelected(_ sender: UIButton) {
        medicationType = 2
        print("Pill selected")
        pillButton.tintColor = UIColor.cyan
        injectionButton.tintColor = UIColor.gray
    }
    
    func createReading() {
        var reading = PFObject(className:"Reading")
        reading["value"] = readingValue
        reading["medicationType"] = medicationType
        reading["carbsTaken"] = carbsIntake
        reading["physicalActivity"] = physicalActivity
        reading["context"] = context
        reading["note"] = notesField.text
        reading.saveInBackground { (saved:Bool, error:Error?) -> Void in
            if saved {
                print("saved worked")
            } else {
                print(error)
            }
        }
    }
    
    
    @IBAction func onPhysicalActivitySelected(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("Mild segement clicked")
            physicalActivity = "Mild"
        case 1:
            print("Moderate segment clicked")
            physicalActivity = "Moderate"
        case 2:
            print("Intense segemnet clicked")
            physicalActivity = "Intense"
        default:
            break;
        }  //Switch
    }
    
    
    @IBAction func onSave(_ sender: Any) {
        createReading()
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
