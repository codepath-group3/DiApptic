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
    
    static func postMessage(user: PFUser, message: String, image: UIImage?, success: @escaping ()->(), failure: ()->()) {
        let parseMessage = PFObject(className: "Message")
        parseMessage["text"] = message
        parseMessage["user"] = user
        if let image = image {
            let imageData = UIImagePNGRepresentation(image)
            let imageFile = PFFile(name:"imageData", data:imageData!)
            parseMessage["image"] = imageFile
        }
        parseMessage.saveInBackground() { (saved:Bool, error:Error?) -> Void in
            if saved {
                success();
                print("message saved")
            } else {
                print(error)
            }

        }
    }
    
    static func getMessages(user: PFUser, success: @escaping (_ messages: [Message])->(), failure: ()->()) {
        let query = PFQuery(className: "Message")
        // TODO: add where clause to include user id
        //query.whereKey("user", equalTo: user)
        query.includeKey("user")
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
        let query = PFQuery(className: "Recording")
        query.whereKey("user", equalTo: PFUser.current()!)
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
