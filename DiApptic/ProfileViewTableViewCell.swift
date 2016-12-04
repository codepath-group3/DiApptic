//
//  ProfileViewTableViewCell.swift
//  DiApptic
//
//  Created by Tushar Humbe on 11/28/16.
//  Copyright © 2016 Faheem Hussain. All rights reserved.
//

import UIKit

class ProfileViewTableViewCell: UITableViewCell {

    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var postContent: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileImageView.layer.cornerRadius = 4.0;
        timestampLabel.textColor = UIColor.gray
        usernameLabel.textColor = UIColor.gray
        postContent.textColor = Styles.darkGray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
