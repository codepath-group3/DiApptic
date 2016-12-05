//
//  EditProfileViewController.swift
//  DiApptic
//
//  Created by Neha Samant on 12/3/16.
//  Copyright © 2016 Faheem Hussain. All rights reserved.
//

import UIKit
import Parse

class EditProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ProfileCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var email: String! = ""
    var password: String! = ""
    var firstName: String! = ""
    var lastName: String! = ""
    var profession: String! {
        didSet {
            if oldValue != nil {
                print("old value", oldValue)
            }
            print("new value", profession)
        }
    }
    
    let userAttributesLabels : [String] = ["E-mail address", "First Name", "Last Name", "Profession"]
    
    var userAttributesValues : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("did IT COME HERE")
        getCurrentUserDetails()
        
        userAttributesValues = [email, firstName, lastName, profession]
        // Do any additional setup after loading the view.
        
        let saveBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.plain, target: self, action: #selector(CreateReadingViewController.onSave))
        self.navigationItem.rightBarButtonItem  = saveBarButtonItem

        
        let headerNib = UINib(nibName: "EditProfileHeaderCell", bundle: nil)
        tableView.register(headerNib, forCellReuseIdentifier: "EditProfileHeaderCell")
        
        let cellNib = UINib(nibName: "EditProfileDetailCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "EditProfileDetailCell")
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.tableHeaderView?.frame.size = CGSize(width: UIScreen.main.bounds.size.width, height: 1);

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Plus 1 for header view
        return 5;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "EditProfileHeaderCell", for: indexPath) as! EditProfileHeaderCell;
            cell.usernameLabel.text = PFUser.current()?.username
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
        print("@@@@@Profession", userAttributesValues)
        saveUserDetails()
        let homeVC = HomeViewController(nibName: "HomeViewController", bundle: nil)
        self.navigationController?.pushViewController(homeVC, animated: true)
    }
    
    func didValueChange(cell: UITableViewCell!, newValue: String!) {
        let index = (cell as! EditProfileDetailCell).index
        userAttributesValues[index!] = newValue
        print("@@@@@@", newValue)
        print("*****", userAttributesValues[index!])
    }


    func saveUserDetails() {
        let currentUser = PFUser.current()
        
        currentUser?["email"] = userAttributesValues[0]
        currentUser?["firstName"] = userAttributesValues[1]
        currentUser?["lastName"] = userAttributesValues[2]
        currentUser?["profession"] = userAttributesValues[3]
        print("#####", userAttributesValues[3])
        currentUser?.saveInBackground { (saved:Bool, error:Error?) -> Void in
                        if saved {
                            print("saved worked")
                        } else {
                            print(error)
                        }

        }
    }
    
//    func editUserDetails() {
//        print("@@@@",PFUser.current())
//        let currentUser = PFUser.current()
//    
//        currentUser["email"] = emailField.text
//        currentUser["username"] = emailField.text
//        currentUser["firstName"] = firstNameField.text
//        currentUser["lastName"] = lastNameField.text
//        currentUser["profession"] = professionField.text        user.saveInBackground { (saved:Bool, error:Error?) -> Void in
//            if saved {
//                print("saved worked")
//            } else {
//                print(error)
//            }
//        }
//    }

}
