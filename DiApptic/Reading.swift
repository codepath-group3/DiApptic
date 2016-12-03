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
    
    var id: Int!
    var type: String!
    var timestamp: NSDate!
    var value: Int!
    var medicationType: Int!
    var context: String!
    var carbsTaken: Int!
    var physicalActivity: String!
    var note: String!
    var shared: Bool!
    var sharedWith: String!
    
    
    init (object: PFObject) {
        type = object["type"] as! String?;
        value = object["value"] as! Int?;
        medicationType = object["medicationType"] as! Int?;
        context = object["context"] as! String?;
        carbsTaken = object["carbsTaken"] as! Int?;
        physicalActivity = object[physicalActivity] as! String?;
        note = object["note"] as! String?;
        

    }
    
    class func readingsFromArray(array: [PFObject]) -> [Reading]{
        var readings = [Reading]()
        
        for object in array {
            readings.append(Reading(object: object))
        }
        
        return readings
    }

}
