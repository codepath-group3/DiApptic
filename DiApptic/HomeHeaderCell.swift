//
//  HomeHeaderCell.swift
//  DiApptic
//
//  Created by Tushar Humbe on 12/3/16.
//  Copyright © 2016 Faheem Hussain. All rights reserved.
//

import UIKit

class HomeHeaderCell: UITableViewCell {

    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    //@IBOutlet weak var profileImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // Profile image: radius, border
        profileImage.layer.cornerRadius = self.profileImage.frame.size.width/2
        
        profileImage.layer.borderWidth = 1.0
        profileImage.layer.borderColor = Styles.lightBlue.cgColor
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        //super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
//    class func fromNib() -> HomeHeaderCell {
//        return Bundle.main.loadNibNamed("HomeHeaderCell", owner: nil, options: nil) as! HomeHeaderCell
//    }

}
