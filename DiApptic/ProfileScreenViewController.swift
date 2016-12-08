//
//  ProfileScreenViewController.swift
//  DiApptic
//
//  Created by Tushar Humbe on 11/13/16.
//  Copyright © 2016 Faheem Hussain. All rights reserved.
//

import UIKit
import Parse

class ProfileScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var currentUser: PFUser?
    var data = [Message]()
    weak var delegate: LogoutDelegate?
    var time = ["1m", "4m", "10m", "17m", "20m", "40m", "43m"]
    
    override func viewDidAppear(_ animated: Bool) {
    ParseUtils.getMessages(user: currentUser!, success: { (messages: [Message]) in
            self.data = messages;
            self.tableView.reloadData();
            }, failure: {
                
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentUser = PFUser.current();
        
        let composeButton = UIBarButtonItem(image: UIImage(named:"compose24x24") , style: UIBarButtonItemStyle.plain, target: self, action: #selector(ProfileScreenViewController.onCompose))
        self.navigationItem.rightBarButtonItem = composeButton;
        
        let signoutButton = UIBarButtonItem(image: UIImage(named:"logout24x24"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(ProfileScreenViewController.onSignOut))
        self.navigationItem.leftBarButtonItem = signoutButton
        
        let headerNib = UINib(nibName: "HomeHeaderCell", bundle: nil)
        tableView.register(headerNib, forCellReuseIdentifier: "profileViewHeader.identifier")
        
        let cellNib = UINib(nibName: "ProfileViewTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "profileView.identifier")
        
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
    
    func onCompose() {
        let composeVC = ComposeViewController(nibName: "ComposeViewController", bundle: nil)
        let composeNavigation = UINavigationController(rootViewController: composeVC)
        self.present(composeNavigation, animated: true)
    }
    
    func onSignOut() {
        // TODO: nil current user
        delegate?.didLogout();
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Plus 1 for header view
        return self.data.count + 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            let user = PFUser.current()!
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "profileViewHeader.identifier", for: indexPath) as! HomeHeaderCell;
            cell.usernameLabel.text = (user["firstName"] as! String) + " " + (user["lastName"] as! String)
            cell.selectionStyle  = .none
            
            let profileImg = user["profilePicture"] as? PFFile
            if let profileImg = profileImg {
                profileImg.getDataInBackground(block: { (imageData: Data?, error:Error?) -> Void in
                    if error == nil {
                        let image = UIImage(data: imageData!)
                        cell.profileImage.image = image
                    }
                })
            } else {
                cell.profileImage.image = UIImage(named: "user128x128.png")
            }
            
            //print (PFUser.current()?.parseClassName)
            return cell
        }
        let message = data[indexPath.row - 1]
        let user = message.user!
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "profileView.identifier", for: indexPath) as! ProfileViewTableViewCell;
        if (indexPath.row < time.count-1) {
            cell.timestampLabel.text = time[indexPath.row]
        } else {
            cell.timestampLabel.text = "1h"
        }
        
        if message.numImages > 0 {
            //ParseUtils.getImages(message: message, user: user)
            cell.attachmentTrayHeight?.constant = 50;
            ParseUtils.getImages(message: message.messagePFObject!, user: user, success: { (images: [UIImage]) in
                    print("images retrieved: \(images.count)")
                    var number = 0
                    for uiImage in images {
                        let imageView  = UIImageView(frame: CGRect(x: 5 + (number * 55), y: 10, width: 50, height: 50))
                        imageView.image = uiImage
                        number = number + 1;
                        cell.attachmentScrollView?.addSubview(imageView)
                    }
                }, failure: {
                    print("image retrieved failed")
            })
        } else {
            if let attachmentScroll = cell.attachmentScrollView {
                //cell.attachmentScrollView.removeFromSuperview()
                let views = cell.attachmentScrollView.subviews
                for view in views {
                    view.removeFromSuperview()
                }
            }
            cell.attachmentTrayHeight?.constant = 1;
            
        }
        
        let profileImg = user["profilePicture"] as? PFFile
        if let profileImg = profileImg {
            profileImg.getDataInBackground(block: { (imageData: Data?, error:Error?) -> Void in
                if error == nil {
                    let image = UIImage(data: imageData!)
                    cell.profileImageView.image = image
                }
            })
        } else {
            cell.profileImageView.image = UIImage(named: "user128x128.png")
        }
        cell.postContent.text = data[indexPath.row - 1].messageText;
        cell.usernameLabel.text = (user["firstName"] as! String) + " " + (user["lastName"] as! String)
        return cell;
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true;
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if (indexPath.row == 0) {
            return [];
        }
        
        
        let favorite = UITableViewRowAction(style: .normal, title: "Like") { action, index in
            print("favorite button tapped")
        }
        favorite.backgroundColor = Styles.darkBlue
        let reply = UITableViewRowAction(style: .normal, title: "Reply") { action, index in
            print("favorite button tapped")
        }
        reply.backgroundColor = Styles.lightBlue
        return [favorite, reply]
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
