//
//  EditProfileViewController.swift
//  DiApptic
//
//  Created by Neha Samant on 12/3/16.
//  Copyright © 2016 Faheem Hussain. All rights reserved.
//

import UIKit
import Parse
import Toaster

class EditProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ProfileCellDelegate, ProfileHeaderCellDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var profilePicture: UIImage!
    var email: String! = ""
    var password: String! = ""
    var firstName: String! = ""
    var lastName: String! = ""
    var profession: String! = ""
    
    var originalImage: UIImage?
    var number = 0;
    
    let userAttributesLabels : [String] = ["E-mail address", "First Name", "Last Name", "Profession"]
    
    var userAttributesValues : [String] = []
    
    var cell: EditProfileHeaderCell!
    
    var loadingUtils = LoadingIndicatorUtils();
    
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
            cell = self.tableView.dequeueReusableCell(withIdentifier: "EditProfileHeaderCell", for: indexPath) as! EditProfileHeaderCell;
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

        let user = PFUser.current()
        if let userEmail = user?["email"] {
            email = userEmail as! String
        }
        if let userFirstName = user?["firstName"]  {
            firstName =  userFirstName as! String
        }
        
        if let userLastName = user?["lastName"]  {
            lastName = userLastName as! String
        }
        
        if let userProfession = user?["profession"]  {
            profession = userProfession as! String
        }
        
        if let userPicture = PFUser.current()!.value(forKey: "profilePicture") as? PFFile {
            userPicture.getDataInBackground(block: { (imageData: Data?, error:Error?) -> Void in
                if error == nil {
                    let image = UIImage(data: imageData!)
                    self.cell.profileImage?.image = image
                }
            })
        }
    }

    func onSave() {
        loadingUtils.showActivityIndicator(uiView: self.view)
        saveUserDetails()
    }
    
    func didValueChange(cell: UITableViewCell!, newValue: String!) {
        let index = (cell as! EditProfileDetailCell).index
        userAttributesValues[index!] = newValue
    }

    func changeImage() {
        let imageVC = UIImagePickerController()
        imageVC.delegate = self
        imageVC.allowsEditing = true
        imageVC.sourceType = UIImagePickerControllerSourceType.photoLibrary
        //imageVC.sourceType = UIImagePickerControllerSourceType.camera
    
        self.present(imageVC, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
                // Get the image captured by the UIImagePickerController
                originalImage = info[UIImagePickerControllerEditedImage] as! UIImage
                cell.profileImage?.image = originalImage
                number = number + 1;
                //bottomConstraint.constant = 52
                // Dismiss UIImagePickerController to go back to your original view controller
                dismiss(animated: true, completion: nil)
    }

    
    func saveUserDetails() {
        let currentUser = PFUser.current()
        
        currentUser?["email"] = userAttributesValues[0]
        currentUser?["firstName"] = userAttributesValues[1]
        currentUser?["lastName"] = userAttributesValues[2]
        currentUser?["profession"] = userAttributesValues[3]
        currentUser?.saveInBackground { (saved:Bool, error:Error?) -> Void in
            if error == nil {
                let imageData  = UIImagePNGRepresentation((self.cell.profileImage?.image)!)
                var parseImageFile = PFFile(name: "upload_image.jpg", data: imageData!)
                currentUser?["profilePicture"] = parseImageFile
                currentUser?.saveInBackground { (saved:Bool, error:Error?) -> Void in
                    if error == nil {
                        self.loadingUtils.hideActivityIndicator(uiView: self.view)
                        Toast(text: "Saved Profile").show()
                    } else {
                        Toast(text: "Error in Saving Profile").show()
                    }
                }
            }
        }
    }
    
    func getNoOfMessages() {
        
    }

}
