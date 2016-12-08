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
    @IBOutlet weak var statusSection: UIStackView!
    
    @IBOutlet weak var mgdlLabel: UILabel!
    
    var reading: Reading!
    
    let dateFormatter: DateFormatter = DateFormatter()
    
    private var _reading: Reading! {
        didSet(oldValue) {
            if reading != nil {
                dateLabel.text = dateFormatter.string(from: _reading.timestamp)
                noteLabel.text = _reading.note
                var readingColor: UIColor!
                if _reading.isLow() {
                    readingColor = UIColor.yellow
                }else if _reading.isNormal() {
                    readingColor = Styles.brightGreen
                }else {
                    readingColor = Styles.orange
                }
                readingValueLabel.textColor = readingColor
                bloodDropImageView.tintColor = readingColor
                mgdlLabel.textColor = readingColor
                medicationImageView.tintColor = Styles.darkerGray
                if _reading.medication == .none {
                    medicationSection.isHidden = true
                }else {
                    if (_reading.medication == .insulin){
                        medicationLabel.text = "Insulin Injected"
                        medicationImageView.image = UIImage(named: "syringe24x24")
                    }else {
                        medicationLabel.text = "Oral Medication Taken"
                        medicationImageView.image = UIImage(named: "pill24x24")
                    }
                    
                }
                statusLabel.text = _reading.status.rawValue
                if _reading.status == .general {
                    statusImageView.image = UIImage(named: "user24x24")
                }else if _reading.status == .fasting {
                    statusImageView.image = UIImage(named: "dawn24x24")
                }else if _reading.status == .beforeMeal {
                    statusImageView.image = UIImage(named: "hamburger24x24")
                }else if _reading.status == .afterMeal {
                    statusImageView.image = UIImage(named: "dinner24x24")
                }
                statusImageView.tintColor = Styles.darkerGray
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateStyle = .long
        edgesForExtendedLayout = []
        _reading = reading
         readingValueLabel.countFrom(fromValue: Float(1), to: Float(_reading.value), withDuration: 1.0, andAnimationType: .EaseInOut, andCountingType: .Int)
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
