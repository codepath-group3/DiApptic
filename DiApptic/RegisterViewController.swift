//
//  RegisterViewController.swift
//  DiApptic
//
//  Created by Neha Samant on 11/20/16.
//  Copyright © 2016 Faheem Hussain. All rights reserved.
//

import UIKit
import Parse

class RegisterViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var firstnameField: UITextField!
    @IBOutlet weak var lastnameField: UITextField!
    @IBOutlet weak var professionField: UITextField!
    @IBOutlet weak var inlineUsernameError: UILabel!
    @IBOutlet weak var inlineLastnameError: UILabel!
    @IBOutlet weak var inlineFirstnameError: UILabel!
    @IBOutlet weak var inlinePasswordError: UILabel!
    @IBOutlet weak var inlineEmailError: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameField.delegate = self
        password.delegate = self
        emailField.delegate = self
        firstnameField.delegate = self
        lastnameField.delegate = self
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        inlineEmailError.isHidden = true
        inlinePasswordError.isHidden = true
        inlineUsernameError.isHidden = true
        inlineFirstnameError.isHidden = true
        inlineLastnameError.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onRegister(_ sender: UIButton) {
        checkForErrors()
        registerUser()
    }
    
    func checkForErrors() {
        if((usernameField.text?.characters.count)! < 4) {
            inlineUsernameError.isHidden = false
            inlineUsernameError.text = "Username must be greater than 5 characters "
        }
        if((password.text?.characters.count)! < 4) {
            inlinePasswordError.isHidden = false
            inlinePasswordError.text = "Password must be greater than 6 characters "
        }
        if((emailField.text?.characters.count)! < 8) {
            inlineEmailError.isHidden = false
            inlineEmailError.text = "Email must be greater than 8 characters "
        }
        if((firstnameField.text?.characters.count)! < 3) {
            inlineFirstnameError.isHidden = false
            inlineFirstnameError.text = "Firstname must be greater than 3 characters "
        }
        if((lastnameField.text?.characters.count)! < 2) {
            inlineLastnameError.isHidden = false
            inlineLastnameError.text = "Last name must be greater than 2 characters "
        }
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
