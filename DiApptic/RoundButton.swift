//
//  RoundButton.swift
//  DiApptic
//
//  Created by Faheem Hussain on 11/23/16.
//  Copyright © 2016 Faheem Hussain. All rights reserved.
//

import UIKit
extension UIImage {
    func maskWithColor(color: UIColor) -> UIImage? {
        let maskImage = cgImage!
        
        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        
        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)
        
        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    }
}
public class RoundButton: UIButton {
    
    override public var isSelected: Bool {
        didSet {
            if isSelected {
                transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                backgroundColor = Styles.lightBlue
                layer.borderColor = Styles.lightBlue.cgColor
                imageView?.tintColor = UIColor.white
                UIView.animate(withDuration: 1.0,
                               delay: 0,
                               usingSpringWithDamping: 0.2,
                               initialSpringVelocity: 6.0,
                               options: .allowUserInteraction,
                               animations: { [weak self] in
                                self?.transform = .identity
                    },
                               completion: nil)
            }else {
                UIView.animate(withDuration: 0.5, animations: {
                    self.backgroundColor = .clear
                    self.layer.borderColor = UIColor.lightGray.cgColor
                    self.imageView?.tintColor = .lightGray
                })
              
            }
        }
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 0.5 * bounds.size.width
        clipsToBounds = true
        layer.borderWidth = 1.0
        backgroundColor = .clear
        layer.borderColor = UIColor.lightGray.cgColor
        imageView?.tintColor = .lightGray
    }
    
}
