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
    
    private var circleSlider: CircleSlider! {
        didSet {
            self.circleSlider.tag = 0
        }
    }
    
    private var valueLabel: UILabel!
    private var progressLabel: UILabel!
    private var timer: Timer?
    private var progressValue: Float = 0
    private var sliderOptions: [CircleSliderOption] {
        return [
            CircleSliderOption.barColor(UIColor.red),
            CircleSliderOption.thumbColor(UIColor.blue),
            CircleSliderOption.trackingColor(UIColor.green),
            CircleSliderOption.barWidth(20),
            CircleSliderOption.startAngle(-45),
            CircleSliderOption.maxValue(150),
            CircleSliderOption.minValue(20)
            //CircleSliderOption.thumbImage(UIImage(named: "thumb_image")!)
        ]
    }
    private var progressOptions: [CircleSliderOption] {
        return [
            .barColor(UIColor.red),
            .trackingColor(UIColor.blue),
            .barWidth(30),
            .sliderEnabled(false)
        ]
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.buildCircleSlider()
    }
    
    @IBAction func onCarbsSliderSelected(_ sender: UISlider) {
        var currentValue = Int(sender.value)
        print("Slider changing to \(currentValue) ?")
        carbsIntake = currentValue
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.circleSlider.frame = self.readingSliderArea.bounds
        self.valueLabel.center = CGPoint(x: self.circleSlider.bounds.width * 0.5, y: self.circleSlider.bounds.height * 0.5)
    }
    
    private func buildCircleSlider() {
        self.circleSlider = CircleSlider(frame: self.readingSliderArea.bounds, options: self.sliderOptions)
        self.circleSlider?.addTarget(self, action: #selector(valueChange(sender:)), for: .valueChanged)
        self.readingSliderArea.addSubview(self.circleSlider!)
        self.valueLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        self.valueLabel.textAlignment = .center
        self.circleSlider.addSubview(self.valueLabel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func valueChange(sender: CircleSlider) {
        switch sender.tag {
        case 0:
            self.valueLabel.text = "\(Int(sender.value))"
            readingValue = Int(self.valueLabel.text!)
        case 1:
            self.progressLabel.text = "\(Int(sender.value))%"
        default:
            break
        }
    }
    
    @IBAction func onBreakfastSelected(_ sender: UIButton) {
        context = "Breakfast"
        print("Breakfast selected")
    }
    
    @IBAction func onLunchSelected(_ sender: UIButton) {
        context = "Lunch"
        print("Lunch selected")
    }
    
    @IBAction func onDinnerSelected(_ sender: UIButton) {
        context = "Dinner"
        print("Dinner selected")
    }

    @IBAction func onInjectionSelected(_ sender: Any) {
        medicationType = 1
        print("Injection selected")
    }
    
    @IBAction func onPillSelected(_ sender: UIButton) {
        medicationType = 2
        print("Pill selected")
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
