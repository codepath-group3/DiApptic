//
//  ComposeViewController.swift
//  DiApptic
//
//  Created by Tushar Humbe on 11/20/16.
//  Copyright © 2016 Faheem Hussain. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    @IBOutlet weak var textArea: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let composeButton = UIBarButtonItem(title: "Compose", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ComposeViewController.onCompose))
        self.navigationItem.rightBarButtonItem = composeButton;
        
        textArea.text = "Share a tip..."
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onCompose() {
        
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
