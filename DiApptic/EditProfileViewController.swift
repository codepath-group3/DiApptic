//
//  EditProfileViewController.swift
//  DiApptic
//
//  Created by Neha Samant on 12/3/16.
//  Copyright © 2016 Faheem Hussain. All rights reserved.
//

import UIKit
import Parse

class EditProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ProfileCellDelegate, ProfileHeaderCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var profileImage: UIImage!
    var email: String! = ""
    var password: String! = ""
    var firstName: String! = ""
    var lastName: String! = ""
    var profession: String! = ""
    
    let userAttributesLabels : [String] = ["E-mail address", "First Name", "Last Name", "Profession"]
    
    var userAttributesValues : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrentUserDetails()
        userAttributesValues = [email, firstName, lastName, profession]
        // Do any additional setup after loading the view.
        
        let saveBarButtonItem = UIBarButtonItem(image: UIImage(named:"save24x24") , style: UIBarButtonItemStyle.plain,  target: self, action: #selector(CreateReadingViewController.onSave))
        self.navigationItem.rightBarButtonItem  = saveBarButtonItem

        let headerNib = UINib(nibName: "EditProfileHeaderCell", bundle: nil)
        tableView.register(headerNib, forCellReuseIdentifier: "EditProfileHeaderCell")
        
        let cellNib = UINib(nibName: "EditProfileDetailCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "EditProfileDetailCell")
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView?.frame.size = CGSize(width: UIScreen.main.bounds.size.width, height: 1);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "EditProfileHeaderCell", for: indexPath) as! EditProfileHeaderCell;
            cell.imageChangeDelegate = self
            let user = PFUser.current()!
            cell.usernameLabel.text = (user["firstName"] as! String) + " " + (user["lastName"] as! String)
            cell.selectionStyle = .none
            return cell
        }
        let detailCell = self.tableView.dequeueReusableCell(withIdentifier: "EditProfileDetailCell", for: indexPath) as! EditProfileDetailCell;
        detailCell.selectionStyle = .none
        detailCell.valueChangeDelegate = self
        let index = indexPath.row
        if (index > 0) {
            detailCell.titleLabel.text = userAttributesLabels[index-1]
            detailCell.valueField.text = userAttributesValues[index-1]
            detailCell.index = index-1
        }
        return detailCell;
    }
    
    func getCurrentUserDetails() {
        var query = PFUser.query()
        query?.whereKey("username", equalTo:PFUser.current()?.username!)
        var user: PFUser!
        do {
            user = try query?.findObjects().first as! PFUser
        } catch {
            print("Error finding user")
        }
        if let userEmail = user["email"] {
            email = userEmail as! String
        }
        if let userFirstName = user["firstName"]  {
            firstName =  userFirstName as! String
        }
        
        if let userLastName = user["lastName"]  {
            lastName = userLastName as! String
        }
        
        if let userProfession = user["profession"]  {
            profession = userProfession as! String
        }
    }

    func onSave() {
        saveUserDetails()
        let homeVC = ProfileScreenViewController(nibName: "ProfileScreenViewController", bundle: nil)
        self.navigationController?.pushViewController(homeVC, animated: true)
    }
    
    func didValueChange(cell: UITableViewCell!, newValue: String!) {
        let index = (cell as! EditProfileDetailCell).index
        userAttributesValues[index!] = newValue
    }

    func didImageChange(newProfileImage : UIImage!) {
        profileImage = newProfileImage
    }
    
    func saveUserDetails() {
        let currentUser = PFUser.current()
        
        currentUser?["email"] = userAttributesValues[0]
        currentUser?["firstName"] = userAttributesValues[1]
        currentUser?["lastName"] = userAttributesValues[2]
        currentUser?["profession"] = userAttributesValues[3]
        currentUser?.saveInBackground { (saved:Bool, error:Error?) -> Void in
            if error == nil {
                //var imageData  = UIImagePNGRepresentation(self.profileImage)
                //var parseImageFile = PFFile(name: "upload_image.jpg", data: imageData!)
                //currentUser?["profilePicture"] = parseImageFile
                currentUser?.saveInBackground { (saved:Bool, error:Error?) -> Void in
                    if error == nil {
                        print("data uploaded")
                    } else {
                        print("error")
                    }
                }
            }
        }
    }
    
    func getNoOfMessages() {
        
    }

}
