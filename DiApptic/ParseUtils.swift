//
//  ParseUtils.swift
//  DiApptic
//
//  Created by Tushar Humbe on 12/2/16.
//  Copyright © 2016 Faheem Hussain. All rights reserved.
//

import Foundation
import Parse

class ParseUtils {
    
    static func postMessage(message: String, success: @escaping ()->(), failure: ()->()) {
        let parseMessage = PFObject(className: "Message")
        parseMessage["text"] = message
        parseMessage.saveInBackground() { (saved:Bool, error:Error?) -> Void in
            if saved {
                success();
                print("message saved")
            } else {
                print(error)
            }

        }
    }
    
    static func getMessages(userId: String, success: @escaping (_ messages: [Message])->(), failure: ()->()) {
        let query = PFQuery(className: "Message")
        // TODO: add where clause to include user id
        query.order(byDescending: "createdAt")
        query.findObjectsInBackground { (objects:[PFObject]?, error:Error?) in
        
            if let objects = objects {
                let messages = Message.messageFromArray(array: objects)
                success(messages);
            } else {
                print("could not retrieve messages")
                
            }
        }
    }
    
    static func getReadings (userId: String, success: @escaping (_ readings: [Reading])->(), failure: ()->() ) {
        let query = PFQuery(className: "Reading")
        // TODO: add where clause to include user id
        query.order(byDescending: "createdAt")
        query.findObjectsInBackground { (objects:[PFObject]?, error:Error?) in
            
            if let objects = objects {
                let readings = Reading.readingsFromArray(array: objects)
                success(readings);
            } else {
                print("could not retrieve readings")
                
            }
        }
    }
}
