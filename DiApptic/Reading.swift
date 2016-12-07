//
//  Reading.swift
//  DiApptic
//
//  Created by Neha Samant on 11/17/16.
//  Copyright © 2016 Faheem Hussain. All rights reserved.
//

import UIKit
import Parse

class Reading: NSObject {
    
    var status: Status!
    var timestamp: Date!
    var value: Int!
    var medication: Medication!
    var note: String!

    enum Medication: String {
        case none = "" , pill = "Oral", insulin = "Insulin"
    }
    enum Status: String {
        case general = "", fasting = "Fasting", beforeMeal = "Before Meal", afterMeal = "After Meal"
    }
    
    init (object: PFObject) {
        value = object["value"] as! Int?;
        let medicationString = object["medicationType"] as! String;
        let statusString = object["status"] as! String;
        medication = Medication.init(rawValue: medicationString)
        status = Status.init(rawValue: statusString)
        timestamp = object.updatedAt
        note = object["note"] as! String?;
    }
    func isNormal() -> Bool {
        return (value > 90 && value < 200)
    }
    func isHigh() -> Bool {
        return (value > 200)
    }
    func isLow() -> Bool{
        return (value < 90)
    }
    
    class func readingsFromArray(array: [PFObject]) -> [Reading]{
        var readings = [Reading]()
        
        for object in array {
            readings.append(Reading(object: object))
        }
        
        return readings
    }

}
