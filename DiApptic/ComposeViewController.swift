//
//  ComposeViewController.swift
//  DiApptic
//
//  Created by Tushar Humbe on 11/20/16.
//  Copyright © 2016 Faheem Hussain. All rights reserved.
//

import UIKit
import Parse

class ComposeViewController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var addAttachment: UIImageView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var dividerView: UIView!
    
    @IBOutlet weak var textArea: UITextView!
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    var originalImage: UIImage?
    var loadingUtils = LoadingIndicatorUtils();
    var attachedImages = [UIImage]()
    
    var originalConstraint: NSLayoutConstraint?
    var number = 0;
    
    @IBOutlet weak var attachmentScrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let composeButton = UIBarButtonItem(image: UIImage(named:"cross24x24"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(ComposeViewController.onCancel))
        self.navigationItem.rightBarButtonItem = composeButton;
        let parseUser = PFUser.current()!
        usernameLabel.text = (parseUser["firstName"] as! String) + " " + (parseUser["lastName"] as! String)
        self.navigationController?.navigationBar.backgroundColor = Styles.darkBlue
        
        let addImageTap = UITapGestureRecognizer(target: self, action: #selector(ComposeViewController.addImage))
        addAttachment.isUserInteractionEnabled = true;
        addAttachment.addGestureRecognizer(addImageTap)
        
        textArea.delegate = self;
        textArea.text  = "Share a tip..."
        textArea.textColor = UIColor.lightGray
        
        //scrollView = UIScrollView(frame: view.bounds)
        
        attachmentScrollView.contentSize = CGSize(width: 150, height: 150)
        attachmentScrollView.autoresizingMask = UIViewAutoresizing.flexibleWidth
        
        originalConstraint  = bottomConstraint;
        
        NotificationCenter.default.addObserver(self, selector: #selector(ComposeViewController.onKeyboardUp(notification:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ComposeViewController.onKeyboardDown(notification:)), name: .UIKeyboardWillHide, object: nil)
        postButton.backgroundColor = Styles.lightBlue
        postButton.tintColor = UIColor.white
        postButton.layer.cornerRadius = 4.0
    }
    override func viewDidAppear(_ animated: Bool) {
         print("set to \(bottomConstraint.constant)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPost(_ sender: AnyObject) {
        let user = PFUser.current()!
        loadingUtils.showActivityIndicator(uiView: self.view)
        ParseUtils.postMessage(user: user, message: textArea.text, images: attachedImages, success: {
            self.loadingUtils.hideActivityIndicator(uiView: self.view)
            print("success callback")
            self.dismiss(animated: true, completion: nil)
            }, failure: {
                print("message post failed")
        })
    }
    
    func onCancel() {
        
        dismiss(animated: true, completion: nil)
    }
    
    func addImage() {
        print("adding image")
        let imageVC = UIImagePickerController()
        
        imageVC.delegate = self
        imageVC.allowsEditing = true
        imageVC.sourceType = UIImagePickerControllerSourceType.photoLibrary
        //imageVC.sourceType = UIImagePickerControllerSourceType.camera
        
        self.present(imageVC, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        let imageView  = UIImageView(frame: CGRect(x: 10 + (number * 150), y: 10, width: 130, height: 130))
        imageView.image = originalImage
        attachmentScrollView.addSubview(imageView)
        number = number + 1;
        attachedImages.append(originalImage!)
        //bottomConstraint.constant = 52
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }

    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func onKeyboardUp(notification: NSNotification) {
        originalConstraint = bottomConstraint;
        let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        
        var constant = keyboardSize?.height
        print("keyboard height: \(constant)")
        if (attachmentScrollView.subviews.count > 0) {
            constant = constant! - 52
        }
        //print("on keyboard up setting to \((constant)!)")
        if (bottomConstraint.constant < 268) {
            print("UPPP: \(bottomConstraint.constant)")
            bottomConstraint.constant = bottomConstraint.constant + 268;
        }
    }
    
    func onKeyboardDown(notification: NSNotification) {
        //print("on keyboard down setting to \(originalConstraint?.constant)")
        if (bottomConstraint.constant >= 268) {
            bottomConstraint.constant = bottomConstraint.constant - 268;
        }
    }

}
