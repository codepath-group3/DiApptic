//
//  Styles.swift
//  DiApptic
//
//  Created by Faheem Hussain on 11/27/16.
//  Copyright © 2016 Faheem Hussain. All rights reserved.
//
import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

class Styles: NSObject {
    static let lightBlue = UIColor(netHex: 0x47BBDC)
    static let darkBlue = UIColor(netHex: 0x3895B0)
    static let orange = UIColor(netHex: 0xFF8B33)
    static let lightOrange = UIColor(netHex: 0xFF8B33)
    static let brightRed = UIColor(netHex: 0xE3514A)
    static let brightGreen = UIColor(netHex: 0x8BC333)
    static let lighterGray = UIColor(netHex: 0xF5F5F5)
    static let lightGray = UIColor(netHex: 0xE0E0E0)
    static let darkGray = UIColor(netHex: 0x9E9E9E)
    static let darkerGray = UIColor(netHex: 0x424242)
}
