//
//  HomeScreenViewController.swift
//  DiApptic
//
//  Created by Tushar Humbe on 11/19/16.
//  Copyright © 2016 Faheem Hussain. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var tableTopMarginConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let profileHeaderView = ProfileHeaderView()
        //print(ProfileHeaderView.frame.height)
        
        tableView.tableHeaderView = profileHeaderView
        //tableView.header
        
        // TODO: make this dynamic after reading profile view height
        //tableTopMarginConstraint.constant = 240
        
        
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
