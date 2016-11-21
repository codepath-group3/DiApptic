//
//  RegisterViewController.swift
//  DiApptic
//
//  Created by Neha Samant on 11/20/16.
//  Copyright © 2016 Faheem Hussain. All rights reserved.
//

import UIKit
import Parse

class RegisterViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var firstnameField: UITextField!
    @IBOutlet weak var lastnameField: UITextField!
    @IBOutlet weak var professionField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onRegister(_ sender: UIButton) {
        registerUser()
    }

    func registerUser() {
        var newUser = PFUser()
        newUser["username"] = usernameField.text
        newUser["password"] = password.text
        newUser["email"] = emailField.text
        newUser["firstName"] = firstnameField.text
        newUser["lastName"] = lastnameField.text
        newUser["profession"] = professionField.text
        newUser.signUpInBackground(block: { (saved:Bool, error:Error?) -> Void in
            if saved {
                print("saved worked")
            } else {
                print(error)
            }
        })
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
