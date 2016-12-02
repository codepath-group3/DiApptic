//
//  ProfileScreenViewController.swift
//  DiApptic
//
//  Created by Tushar Humbe on 11/13/16.
//  Copyright © 2016 Faheem Hussain. All rights reserved.
//

import UIKit

class ProfileScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
        
        let composeButton = UIBarButtonItem(title: "Compose", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ComposeViewController.onCompose))
        self.navigationItem.rightBarButtonItem = composeButton;
        
    
        let cellNib = UINib(nibName: "ProfileViewTableViewCell", bundle: nil)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.rowHeight = 120;
        tableView.estimatedRowHeight = 120
        tableView.register(cellNib, forCellReuseIdentifier: "profileView.identifier")
        tableView.dataSource = self;
        tableView.delegate = self;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func onCompose() {
        let composeVC = ComposeViewController(nibName: "ComposeViewController", bundle: nil)
        self.navigationController?.pushViewController(composeVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "profileView.identifier", for: indexPath) as! ProfileViewTableViewCell;
        return cell;
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
