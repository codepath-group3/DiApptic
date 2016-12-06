//
//  EditProfileHeaderCell.swift
//  DiApptic
//
//  Created by Neha Samant on 12/4/16.
//  Copyright © 2016 Faheem Hussain. All rights reserved.
//

import UIKit

protocol ProfileHeaderCellDelegate: class {
    func changeImage()
}

class EditProfileHeaderCell: UITableViewCell, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    weak var imageChangeDelegate: ProfileHeaderCellDelegate!

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView?
    @IBOutlet weak var hba1cView: UIView!
    @IBOutlet weak var glucoseView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let tapGesture = UITapGestureRecognizer(target:self, action:#selector(EditProfileHeaderCell.imagePressed))
        profileImage?.isUserInteractionEnabled = true // this line is important
        profileImage?.addGestureRecognizer(tapGesture)
        
        profileImage?.layer.cornerRadius = 60
        profileImage?.clipsToBounds = true
        profileImage?.layer.borderWidth = 4.0
        profileImage?.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func imagePressed() {
        imageChangeDelegate.changeImage()
    }
}
