//
//  EditProfileDetailCell.swift
//  DiApptic
//
//  Created by Neha Samant on 12/4/16.
//  Copyright © 2016 Faheem Hussain. All rights reserved.
//

import UIKit

protocol ProfileCellDelegate: class {
    func didValueChange(cell : UITableViewCell!, newValue: String!)
}
class EditProfileDetailCell: UITableViewCell {

    var index: Int!
    weak var valueChangeDelegate: ProfileCellDelegate!
    
    @IBOutlet weak var valueField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
   
    @IBAction func onValueChanged(_ sender: UITextField) {
        print("Value changed to: ", sender.text)
        valueChangeDelegate.didValueChange(cell: self, newValue: sender.text)
    }
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
