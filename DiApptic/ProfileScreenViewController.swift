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
            //print (PFUser.current()?.parseClassName)
            return cell
        }
        let user = data[indexPath.row - 1].user!
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "profileView.identifier", for: indexPath) as! ProfileViewTableViewCell;
        cell.timestampLabel.text = "20m"
        if let imageFile = data[indexPath.row - 1].imageFile {
            imageFile.getDataInBackground(block: { (imageData: Data?, error:Error?) -> Void in
                if error == nil {
                    let image = UIImage(data: imageData!)
                    cell.profileImageView.image = image
                }
            })
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
        favorite.backgroundColor = UIColor.red
        let reply = UITableViewRowAction(style: .normal, title: "Reply") { action, index in
            print("favorite button tapped")
        }
        reply.backgroundColor = UIColor.blue
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
