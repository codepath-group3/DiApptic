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

class EditProfileHeaderCell: UITableViewCell, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    weak var imageChangeDelegate: ProfileHeaderCellDelegate!

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var hba1cView: UIView!
    @IBOutlet weak var glucoseView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        let tapGesture = UITapGestureRecognizer(target:self, action:Selector("imagePressed"))
//        profileImage.isUserInteractionEnabled = true // this line is important
//        profileImage.addGestureRecognizer(tapGesture)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func imagePressed() {
        print("adding image")
        let imageVC = UIImagePickerController()
        
        imageVC.delegate = self
        imageVC.allowsEditing = true
        imageVC.sourceType = UIImagePickerControllerSourceType.photoLibrary
        //imageVC.sourceType = UIImagePickerControllerSourceType.camera
        
        //self.present(imageVC, animated: true, completion: nil)
        imageChangeDelegate.didImageChange(newProfileImage: profileImage?.image)
    }
    
    func addImage() {
      
    }
//    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        // Get the image captured by the UIImagePickerController
//        originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
//        
//        let imageView  = UIImageView(frame: CGRect(x: 10 + (number * 150), y: 10, width: 130, height: 130))
//        imageView.image = originalImage
//        attachmentScrollView.addSubview(imageView)
//        number = number + 1;
//        //bottomConstraint.constant = 52
//        // Dismiss UIImagePickerController to go back to your original view controller
//        dismiss(animated: true, completion: nil)
//    }


}
