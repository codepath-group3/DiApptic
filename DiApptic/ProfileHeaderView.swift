//
//  ProfileHeaderView.swift
//  DiApptic
//
//  Created by Tushar Humbe on 11/13/16.
//  Copyright © 2016 Faheem Hussain. All rights reserved.
//

import UIKit

class ProfileHeaderView: UIView {

    @IBOutlet var contentView: UIView!

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var glucoseReadingView: UIView!
    
    @IBOutlet weak var hba1cReadingView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        initSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }   
    
    func initSubviews() {
        // standard initialization logic
        let nib = UINib(nibName: "ProfileHeaderView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        usernameLabel.text = "Tushar Humbe"
        
        // profile image styling
        profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width/2
        profileImageView.clipsToBounds = true
        profileImageView.layer.borderWidth = 3.0
        profileImageView.layer.borderColor = UIColor.gray.cgColor
        
        //readings styling
        glucoseReadingView.layer.cornerRadius = glucoseReadingView.frame.size.width/2 + 1
        glucoseReadingView.clipsToBounds = true;

        hba1cReadingView.layer.cornerRadius = hba1cReadingView.frame.size.width/2 + 2
        hba1cReadingView.clipsToBounds = true;

        addSubview(contentView)
        
    }
    
    static func initFromNib() -> UIView {
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! ProfileHeaderView
        view.initSubviews()
        return view;
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
