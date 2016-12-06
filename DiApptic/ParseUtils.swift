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
    
    static func postMessage(user: PFUser, message: String, images: [UIImage], success: @escaping ()->(), failure: ()->()) {
        let parseMessage = PFObject(className: "Message")
        parseMessage["text"] = message
        parseMessage["user"] = user
        parseMessage["numImages"] = images.count
        
        parseMessage.saveInBackground() { (saved:Bool, error:Error?) -> Void in
            if saved {
                // save the images
                var saveCount = 0;
                for image in images {
                    let imageData = UIImagePNGRepresentation(image)
                    let imageFile = PFFile(name:"imageData", data:imageData!)
                    let parseImage = PFObject(className: "MessageImage")
                    parseImage["user"] = user
                    parseImage["message"] = parseMessage
                    parseImage["image"] = imageFile
                    parseImage.saveInBackground() { (saved:Bool, error:Error?) -> Void in
                        saveCount = saveCount + 1;
                        print("image stored: \(saveCount)")
                        if (saveCount == images.count) {
                            success();
                        }
                        
                    }
                }
                
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
