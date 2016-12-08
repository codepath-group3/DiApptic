//
//  HomeHeaderCell.swift
//  DiApptic
//
//  Created by Tushar Humbe on 12/3/16.
//  Copyright © 2016 Faheem Hussain. All rights reserved.
//

import UIKit

class HomeHeaderCell: UITableViewCell {

    @IBOutlet weak var hba1cLabel: UILabel!
    @IBOutlet weak var hba1cCount: UILabel!
    @IBOutlet weak var glucoseLabel: UILabel!
    @IBOutlet weak var averageLabelColor: UILabel!
    @IBOutlet weak var glucoseCount: UILabel!
    @IBOutlet weak var glucoseView: UIView!
    
    @IBOutlet weak var hba1cView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var averageCount: UILabel!
    //@IBOutlet weak var profileImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // Profile image: radius, border
        profileImage.layer.cornerRadius = 60
        profileImage.clipsToBounds = true
        profileImage.layer.borderWidth = 4.0
        profileImage.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        
        glucoseView.layer.cornerRadius = 35
        glucoseView.clipsToBounds = true
        glucoseView.backgroundColor = Styles.lightBlue
        
        hba1cView.layer.cornerRadius = 35
        hba1cView.clipsToBounds = true
        hba1cView.backgroundColor = Styles.lightBlue
        
        /*glucoseView.transform = CGAffineTransform(rotationAngle: CGFloat(-CGFloat.pi/18))
        
        hba1cView.transform = CGAffineTransform(rotationAngle: CGFloat(CGFloat.pi/18))*/
        glucoseView.backgroundColor = glucoseView.backgroundColor?.withAlphaComponent(0.8)
        hba1cView.backgroundColor = glucoseView.backgroundColor?.withAlphaComponent(0.8)
        glucoseCount.textColor = averageCount.textColor
        glucoseLabel.textColor = averageCount.textColor
        
        hba1cCount.textColor = averageCount.textColor
        hba1cLabel.textColor = averageCount.textColor
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        //super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
//    class func fromNib() -> HomeHeaderCell {
//        return Bundle.main.loadNibNamed("HomeHeaderCell", owner: nil, options: nil) as! HomeHeaderCell
//    }

}
