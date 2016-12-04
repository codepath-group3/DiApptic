//
//  ComposeViewController.swift
//  DiApptic
//
//  Created by Tushar Humbe on 11/20/16.
//  Copyright © 2016 Faheem Hussain. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var addAttachmentButton: UIImageView!
    @IBOutlet weak var textArea: UITextView!
    var number = 0;
    
    @IBOutlet weak var attachmentScrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let composeButton = UIBarButtonItem(title: "Post", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ComposeViewController.onCompose))
        self.navigationItem.rightBarButtonItem = composeButton;
        
        
        let addImageTap = UITapGestureRecognizer(target: self, action: #selector(ComposeViewController.addImage))
        addAttachmentButton.isUserInteractionEnabled = true;
        addAttachmentButton.addGestureRecognizer(addImageTap)
        
        textArea.delegate = self;
        textArea.text  = "Share a tip..."
        textArea.textColor = UIColor.lightGray
        
        //scrollView = UIScrollView(frame: view.bounds)
        attachmentScrollView.layer.borderWidth = 1
        
        attachmentScrollView.contentSize = CGSize(width: 150, height: 150)
        attachmentScrollView.autoresizingMask = UIViewAutoresizing.flexibleWidth
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
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        let imageView  = UIImageView(frame: CGRect(x: 10 + (number * 150), y: 10, width: 130, height: 130))
        imageView.image = originalImage
        attachmentScrollView.addSubview(imageView)
        number = number + 1;
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
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
