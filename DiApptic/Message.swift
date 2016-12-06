//
//  Message.swift
//  DiApptic
//
//  Created by Tushar Humbe on 12/3/16.
//  Copyright © 2016 Faheem Hussain. All rights reserved.
//

import Foundation
import Parse

class Message: NSObject {
    
    var messageText: String?
    var user: PFUser?
    var imageFile: PFFile?
    
    init (object: PFObject) {
        messageText = object["text"] as! String?;
        user = object["user"] as! PFUser;
        imageFile = object["image"] as? PFFile
    }
    
    class func messageFromArray(array: [PFObject]) -> [Message]{
        var messages = [Message]()
        
        for object in array {
            messages.append(Message(object: object))
        }
        
        return messages
    }
}
