//
//  ProfileScreenViewController.swift
//  DiApptic
//
//  Created by Tushar Humbe on 11/13/16.
//  Copyright © 2016 Faheem Hussain. All rights reserved.
//

import UIKit

class ProfileScreenViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

//        let nib = UINib(nibName: "ProfileHeaderView", bundle: nil)
//        let profileHeaderView = nib.instantiate(withOwner: self, options: nil)[0] as! ProfileHeaderView
//        
//        print(profileHeaderView.usernameLabel.text)
        //let profileHeaderView = ProfileHeaderView.initFromNib()
        //tableView.tableHeaderView = profileHeaderView
        //tableView.tableHeaderView = profileHeaderView;
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
