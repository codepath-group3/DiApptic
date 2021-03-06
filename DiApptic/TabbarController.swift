//
//  TabbarController.swift
//  DiApptic
//
//  Created by Faheem Hussain on 11/13/16.
//  Copyright © 2016 Faheem Hussain. All rights reserved.
//

import UIKit

protocol LogoutDelegate: class {
    func didLogout()
}

class TabbarController: UIViewController, CreateReadingDelegate {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tabbarView: UIView!
    
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var addReadingButton: UIButton!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var contentViewBottomSpaceConstraint: NSLayoutConstraint!
    
    weak var delegate: LogoutDelegate?
    
    var buttons: [UIButton] = []
    
    var homeNavigationController: UINavigationController!
    var historyNavigationController: UINavigationController!
    var addReadingNavigationController: UINavigationController!
    var editProfileNavigationController: UINavigationController!
    var navigationControllers: [UINavigationController] = []
    
    var homeViewController: UIViewController!
    var historyViewController: UIViewController!
    var addReadingViewController: CreateReadingViewController!
    var editProfileViewController: UIViewController!
    var viewControllers: [UIViewController] = []
    
    var selectedIndex: Int! {
        didSet {
            if oldValue != nil && oldValue != selectedIndex{
                leftToRight = selectedIndex < oldValue
                buttons[oldValue].tintColor = Styles.darkGray
                buttons[oldValue].setTitleColor(Styles.darkGray, for: UIControlState.normal)
            }
            if oldValue == nil || oldValue != selectedIndex {
                buttons[selectedIndex].tintColor = Styles.lightBlue
                buttons[selectedIndex].setTitleColor(Styles.lightBlue, for: UIControlState.normal)
                contentViewController = navigationControllers[selectedIndex]

            }
        }
    }

    var leftToRight: Bool = true
    var oldCenter: CGPoint!
    var newCenter: CGPoint!
    
    var oldVc: UIViewController!
    
    var contentViewController: UIViewController! {
        didSet(oldContentViewController){
            view.layoutIfNeeded()
            oldVc = oldContentViewController
            contentViewController.willMove(toParentViewController: self)
            contentViewController.view.frame = contentView.bounds
            contentView.addSubview(contentViewController.view)
            if oldContentViewController != nil {
                oldCenter = oldContentViewController.view.center
                newCenter = oldContentViewController.view.center
                contentViewController.view.center.x = newCenter.x + (leftToRight ? -contentView.bounds.size.width :contentView.bounds.size.width)
            }
            contentViewController.didMove(toParentViewController: self)
            self.view.layoutIfNeeded()
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [.curveEaseInOut], animations: {
                if self.oldVc != nil {
                    self.oldVc.view.center.x = self.oldCenter.x + (self.leftToRight ? self.contentView.bounds.size.width : -self.contentView.bounds.size.width)
                    self.contentViewController.view.center.x = self.newCenter.x
                }
            }, completion: {
                (value: Bool) in
                if self.oldVc != nil {
                    self.oldVc.willMove(toParentViewController: nil)
                    self.oldVc.view.removeFromSuperview()
                    //oldContentViewController.removeFromParentViewController()
                    self.oldVc.didMove(toParentViewController: nil)
                }
            })

        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        tabbarView.backgroundColor = Styles.lighterGray
        buttons = [homeButton,historyButton,profileButton, addReadingButton]
        for button: UIButton in buttons {
            layout(button)
        }

        /*let navigation = UINavigationController()
        let profileView = ProfileScreenViewController(nibName: "ProfileScreenViewController", bundle: nil)
        navigation.viewControllers = [profileView]
        homeViewController = navigation;*/

        homeViewController = ProfileScreenViewController(nibName: "ProfileScreenViewController", bundle: nil)
        homeViewController.title = "Home"
        (homeViewController as! ProfileScreenViewController).delegate = delegate;
        homeNavigationController = UINavigationController(rootViewController: homeViewController)

        historyViewController = HistoryViewController(nibName: "HistoryViewController", bundle: nil)
        historyViewController.title = "History and Trends"
        historyNavigationController = UINavigationController(rootViewController: historyViewController)
        addReadingViewController = CreateReadingViewController(nibName: "CreateReadingViewController", bundle: nil)
        addReadingViewController.saveDelegate = self
        addReadingViewController.title = "Measure and Record"
        addReadingNavigationController = UINavigationController(rootViewController: addReadingViewController)
        
        
        editProfileViewController = EditProfileViewController(nibName: "EditProfileViewController", bundle: nil)
        editProfileViewController.title = "Profile"
        editProfileNavigationController = UINavigationController(rootViewController: editProfileViewController)

        viewControllers = [homeViewController, historyViewController ,editProfileViewController,addReadingViewController]
        navigationControllers = [homeNavigationController, historyNavigationController, editProfileNavigationController, addReadingNavigationController]
        for nav in navigationControllers {
            nav.navigationBar.backgroundColor = Styles.darkBlue
        }
        selectedIndex = 0
        //tabButtonDidSelect(buttons[selectedIndex])
        NotificationCenter.default.addObserver(self, selector: #selector(TabbarController.keyboardDidShow(notification:)), name: .UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(TabbarController.keyboardDidShow(notification:)), name: .UIKeyboardDidHide, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func onSaveReading(reading: Reading?) {
        selectedIndex = 1
    }
    fileprivate func layout(_ button: UIButton) {
        let iw = button.imageView!.frame.size.width
        let tw = button.titleLabel!.frame.size.width
        button.imageEdgeInsets = UIEdgeInsetsMake(0, (tw +  iw)/2, 18.0, 0)
        button.tintColor = Styles.darkGray
   }
    @IBAction func onTabButtonTap(_ sender: UIButton) {
        selectedIndex = sender.tag
    }
    func keyboardDidShow(notification: NSNotification){
        
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            if (endFrame?.origin.y)! >= UIScreen.main.bounds.size.height {
                //self.keyboardHeightLayoutConstraint?.constant = 0.0
                self.contentViewBottomSpaceConstraint.constant = 50
            } else {
                //self.keyboardHeightLayoutConstraint?.constant = endFrame?.size.height ?? 0.0
                self.contentViewBottomSpaceConstraint.constant = endFrame?.size.height ?? 50.0
            }
            contentViewController.view.frame = contentView.bounds
            view.layoutIfNeeded()
            /*
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)*/
        }
    }
    func keyboardDidHide(notification: NSNotification){
        
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
