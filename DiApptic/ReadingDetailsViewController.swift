//
//  ReadingDetailsViewController.swift
//  DiApptic
//
//  Created by Faheem Hussain on 12/1/16.
//  Copyright © 2016 Faheem Hussain. All rights reserved.
//

import UIKit


class ReadingDetailsViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var bloodDropImageView: UIImageView!
    @IBOutlet weak var readingValueLabel: CountingLabel!
    @IBOutlet weak var statusImageView: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var medicationImageView: UIImageView!
    @IBOutlet weak var medicationLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var medicationSection: UIStackView!
    var glucoseReading: GlucoseReading!
    
    var reading: GlucoseReading! {
        didSet(oldValue) {
            if reading != nil {
                dateLabel.text = "\(reading.date)"
                noteLabel.text = reading.note
                var readingColor: UIColor!
                if reading.value < 70 {
                    readingColor = UIColor.yellow
                }else if reading.value > 70 && reading.value < 200 {
                    readingColor = Styles.brightGreen
                }else {
                    readingColor = Styles.orange
                }
                readingValueLabel.textColor = readingColor
                bloodDropImageView.tintColor = readingColor
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reading = glucoseReading
        edgesForExtendedLayout = []
         readingValueLabel.countFrom(fromValue: Float(1), to: Float(reading.value), withDuration: 1.0, andAnimationType: .EaseInOut, andCountingType: .Int)
        //medicationSection.isHidden = true
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
