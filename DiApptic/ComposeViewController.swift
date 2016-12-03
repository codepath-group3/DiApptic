//
//  ComposeViewController.swift
//  DiApptic
//
//  Created by Tushar Humbe on 11/20/16.
//  Copyright © 2016 Faheem Hussain. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var textArea: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let composeButton = UIBarButtonItem(title: "Post", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ComposeViewController.onCompose))
        self.navigationItem.rightBarButtonItem = composeButton;
        
        textArea.delegate = self;
        textArea.text  = "Share a tip..."
        textArea.textColor = UIColor.lightGray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // post message to parse
    func onCompose() {
        ParseUtils.postMessage(message: textArea.text, success: { 
            print("success callback")
            self.navigationController?.popViewController(animated: true)
            
            }, failure: {
                print("message post failed")
        })
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
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
