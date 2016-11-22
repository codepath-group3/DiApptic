//
//  LoginViewController.swift
//  DiApptic
//
//  Created by Neha Samant on 11/13/16.
//  Copyright © 2016 Faheem Hussain. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var inlinePasswordError: UILabel!
    @IBOutlet weak var inlineEmailError: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentUser = PFUser.current()
        if currentUser != nil {
            let vc = TabbarController(nibName: "TabbarController", bundle: nil)
            self.navigationController!.pushViewController(vc, animated: true)

        } else {
            usernameField.delegate = self
            passwordField.delegate = self
        }
        addImageInsideTextView(textField: usernameField, image: "clock")
        addImageInsideTextView(textField: passwordField, image: "clock")
    }
    
    func addImageInsideTextView(textField: UITextField, image: String) {
        let imageView = UIImageView();
        let image = UIImage(named: image);
        imageView.image = image;
        imageView.frame = CGRect(x: 10, y: 10, width: 20, height: 20)
        textField.addSubview(imageView)
        let leftView = UIView.init(frame: CGRect(x: 10, y: 0, width: 30, height: 30))
        textField.leftView = leftView;
        textField.leftViewMode = UITextFieldViewMode.always
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
            inlineEmailError.isHidden = true
            inlinePasswordError.isHidden = true
    }
    
   
    @IBAction func onLoginAction(_ sender: Any) {
        let username = self.usernameField.text
        let password = self.passwordField.text
        
        if (username?.characters.count)! < 4 {
            inlineEmailError.isHidden = false
            inlineEmailError.text = "Username must be greater than 5 characters"
            
        } else if (password?.characters.count)! < 6{
            inlinePasswordError.isHidden = false
            inlinePasswordError.text = "Password must be greater than 6 characters"
            
        }else {
            
            PFUser.logInWithUsername(inBackground: username!, password: password!, block: { (user, error) -> Void in
                
                if ((user) != nil) {
                    let vc = TabbarController(nibName: "TabbarController", bundle: nil)
                    self.navigationController!.pushViewController(vc, animated: true)
                } else {
                    let alert = UIAlertView(title: "Error", message: "Invalid email or password", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                }
        })
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

    @IBAction func onSignup(_ sender: UIButton) {
        let vc = RegisterViewController(nibName: "RegisterViewController", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
    }
}
