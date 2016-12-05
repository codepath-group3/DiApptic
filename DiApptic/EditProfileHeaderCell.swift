//
//  EditProfileHeaderCell.swift
//  DiApptic
//
//  Created by Neha Samant on 12/4/16.
//  Copyright © 2016 Faheem Hussain. All rights reserved.
//

import UIKit

protocol ProfileHeaderCellDelegate: class {
    func didImageChange(newProfileImage : UIImage!)
}
class EditProfileHeaderCell: UITableViewCell {
    
    weak var imageChangeDelegate: ProfileHeaderCellDelegate!

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var hba1cView: UIView!
    @IBOutlet weak var glucoseView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let tapGesture = UITapGestureRecognizer(target:self, action:Selector("imagePressed"))
        profileImage.isUserInteractionEnabled = true // this line is important
        profileImage.addGestureRecognizer(tapGesture)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func imagePressed() {
        imageChangeDelegate.didImageChange(newProfileImage: profileImage?.image)
    }

}
