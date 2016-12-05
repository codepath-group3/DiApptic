//
//  EditProfileHeaderCell.swift
//  DiApptic
//
//  Created by Neha Samant on 12/4/16.
//  Copyright © 2016 Faheem Hussain. All rights reserved.
//

import UIKit

class EditProfileHeaderCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var hba1cView: UIView!
    @IBOutlet weak var glucoseView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
