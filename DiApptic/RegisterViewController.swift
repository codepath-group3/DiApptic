//
//  RegisterViewController.swift
//  DiApptic
//
//  Created by Neha Samant on 11/20/16.
//  Copyright © 2016 Faheem Hussain. All rights reserved.
//

import UIKit
import Parse

class RegisterViewController: UIViewController, UITextFieldDelegate, DataDelegate {

    @IBOutlet weak var registerView: UIView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var professionField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var inlineError: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordField.delegate = self
        emailField.delegate = self
        firstNameField.delegate = self
        lastNameField.delegate = self
        getRoundedView(view: registerView)
        getRoundedView(view: signUpButton)
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        inlineError.isHidden = true
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
        if((passwordField.text?.characters.count)! < 4) {
            inlineError.isHidden = false
            inlineError.text = "Password must be greater than 6 characters "
        }
        if((emailField.text?.characters.count)! < 8) {
            inlineError.isHidden = false
            inlineError.text = "Email must be greater than 8 characters "
        }
        if((firstNameField.text?.characters.count)! < 3) {
            inlineError.isHidden = false
            inlineError.text = "Firstname must be greater than 3 characters "
        }
        if((lastNameField.text?.characters.count)! < 2) {
            inlineError.isHidden = false
            inlineError.text = "Last name must be greater than 2 characters "
        }
    }

    func registerUser() {
        var newUser = PFUser()
        newUser["password"] = passwordField.text
        newUser["email"] = emailField.text
        newUser["username"] = emailField.text
        newUser["firstName"] = firstNameField.text
        newUser["lastName"] = lastNameField.text
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
    func getRoundedView(view: UIView) {
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.clear.cgColor
        view.clipsToBounds = true
    }

    func didAddEmail(email: String, password: String) {
        print(email)
        print(password)
    }

}
