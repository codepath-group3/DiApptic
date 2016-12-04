//
//  LoginViewController.swift
//  DiApptic
//
//  Created by Neha Samant on 11/13/16.
//  Copyright © 2016 Faheem Hussain. All rights reserved.
//

import UIKit
import Parse

protocol LoginDelegate: class {
    func didLogin()
}
protocol DataDelegate: class {
   func didAddEmail(email: String, password: String)
}

class LoginViewController: UIViewController, UITextFieldDelegate {

    weak var delegate: LoginDelegate!
    weak var dataDelegate: DataDelegate!
    
    @IBOutlet weak var inlineError: UILabel!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var usernamePasswordSection: UIView!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var emailIcon: UIImageView!
    @IBOutlet weak var passwordIcon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "diabetes.jpg")!)
        let currentUser = PFUser.current()
        if currentUser != nil {
            delegate.didLogin()
        } else {
            usernameField.delegate = self
            passwordField.delegate = self
        }
        emailIcon.tintColor = Styles.lightGray
        passwordIcon.tintColor = Styles.lightGray
        getRoundedView(view: signInButton)
        getRoundedView(view: signUpButton)
        getRoundedView(view: usernamePasswordSection)
        
    }
    
    func getRoundedView(view: UIView) {
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.clear.cgColor
        view.clipsToBounds = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
            inlineError.isHidden = true
            inlineError.isHidden = true
    }
    
    @IBAction func onSignInAction(_ sender: Any) {
        let username = self.usernameField.text
        let password = self.passwordField.text
        
        if (username?.characters.count)! < 4 {
            inlineError.isHidden = false
            inlineError.text = "Username must be greater than 5 characters"
            
        } else if (password?.characters.count)! < 6{
            inlineError.isHidden = false
            inlineError.text = "Password must be greater than 6 characters"
            
        }else {
            
            PFUser.logInWithUsername(inBackground: username!, password: password!, block: { (user, error) -> Void in
                
                if ((user) != nil) {
                    //let vc = TabbarController(nibName: "TabbarController", bundle: nil)
                    //self.navigationController!.pushViewController(vc, animated: true)
                    self.delegate.didLogin()
                } else {
                    self.inlineError.isHidden = false
                    self.inlineError.text = "Invalid email or password"
                }
            })
        }
        
    }
   
    @IBAction func onSignUpAction(_ sender: Any) {
        if usernameField.text != nil && passwordField.text !=  nil {
            dataDelegate.didAddEmail(email: "ksdhjsgdfs", password: "sadhsgfs")
        }
        let vc = RegisterViewController(nibName: "RegisterViewController", bundle: nil)
        self.present(vc, animated: true)
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
