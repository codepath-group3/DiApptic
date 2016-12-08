//
//  Reading.swift
//  DiApptic
//
//  Created by Neha Samant on 11/17/16.
//  Copyright © 2016 Faheem Hussain. All rights reserved.
//

import UIKit
import Parse

enum Medication: String {
    case none = "None"
    case pill = "Oral"
    case insulin = "Insulin"
}
enum Status: String {
    case general = "General"
    case fasting = "Fasting"
    case beforeMeal = "Before Meal"
    case afterMeal = "After Meal"
}

class Reading: NSObject {
    
    var status: Status!
    var timestamp: Date!
    var value: Int!
    var medication: Medication!
    var note: String!
    
    private let fastingMin = 70
    private let fastingMax = 130
    private let mealMin = 90
    private let mealMax = 180
    
    private static let statuses: [String] = ["General", "Fasting", "Before Meal", "After Meal"]
    private static let medications: [String] =  ["None" , "Oral", "Insulin"]
    private static var readings: [Reading]!
    
    init (object: PFObject) {
        value = object["value"] as! Int?;
        let medicationString = object["medicationType"] as! String;
        let statusString = object["status"] as! String;
        medication = Medication.init(rawValue: medicationString)
        status = Status.init(rawValue: statusString)
        timestamp = object.updatedAt
        note = object["note"] as! String?;
    }
    init(timestamp: Date, status: Status, medication: Medication, value: Int, note: String){
        self.timestamp = timestamp
        self.status = status
        self.medication = medication
        self.value = value
        self.note = note
    }
    func isNormal() -> Bool {
        var normal = false
        switch status! {
        case .general:
            normal = (value > 70 && value < 180)
        case .fasting:
            normal = (value > fastingMin && value < fastingMax)
        case .beforeMeal:
            normal = (value > fastingMin && value < fastingMax)
        case .afterMeal:
            normal = (value > mealMin && value < mealMax)
        }
        return normal
    }
    func isHigh() -> Bool {
        var high = false
        switch status! {
        case .general:
            high = (value > mealMax)
        case .fasting:
            high = (value > fastingMax)
        case .beforeMeal:
            high = (value > fastingMax)
        case .afterMeal:
            high = (value > mealMax)
        }
        return high
    }
    func isLow() -> Bool{
        var low = false
        switch status! {
        case .general:
            low = (value < fastingMin)
        case .fasting:
            low = (value < fastingMin)
        case .beforeMeal:
            low = (value < fastingMin)
        case .afterMeal:
            low = (value < mealMin)
        }
        return low
    }
    
    class func readingsFromArray(array: [PFObject]) -> [Reading]{
        var readings = [Reading]()
        
        for object in array {
            readings.append(Reading(object: object))
        }
        
        return readings
    }
    class func add(reading: Reading) {
        var randomReadings = getRandomReadings()
        randomReadings.append(reading)
    }
    class func getRandomReadings() -> [Reading] {
        let maxPerDay = 3
        if readings != nil {
            return readings
        } else {
            let dateFormatter: DateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            var readings: [Reading] = []
            
            for year in 2016...2016 {
                for month in 11...12 {
                    for day in 1...30 {
                        for _ in 1...maxPerDay {
                            let glucoseValue = Double(arc4random_uniform(175)+50)
                            let statusIndex = Int(arc4random_uniform(UInt32(statuses.count) - 1))
                            let medicationIndex = Int(arc4random_uniform(UInt32(medications.count) - 1))
                            let status = Status(rawValue: statuses[statusIndex])!
                            let medication = Medication(rawValue: medications[medicationIndex])!
                            let reading = Reading(timestamp: dateFormatter.date(from: "\(month)/\(day)/\(year)")!, status: status, medication: medication, value: Int(glucoseValue), note: "As the doctor prescribed I took 500mg of Metformin.")
                            readings.append(reading)
                        }
                    }
                }
            }
            self.readings = readings
            return self.readings
        }
    }
    class func filter(medication: Medication?, status: Status?) -> [Reading] {
        var filteredReadings: [Reading] = []
        if medication != nil {
            for reading in self.readings {
                if (reading.medication == medication){
                    filteredReadings.append(reading)
                }
                
            }
        } else if status != nil {
            for reading in self.readings {
                if (reading.status == status){
                    filteredReadings.append(reading)
                }
                
            }
        }
        return filteredReadings
    }

}
