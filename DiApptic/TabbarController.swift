//
//  TabbarController.swift
//  DiApptic
//
//  Created by Faheem Hussain on 11/13/16.
//  Copyright © 2016 Faheem Hussain. All rights reserved.
//

import UIKit

class TabbarController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var addReadingButton: UIButton!
    var buttons: [UIButton] = []
    
    var homeViewController: UIViewController!
    var historyViewController: UIViewController!
    var addReadingViewController: UIViewController!
    var viewControllers: [UIViewController] = []
    
    var selected: Int = 0
    var contentViewController: UIViewController! {
        didSet(oldContentViewController){
            view.layoutIfNeeded()
            if oldContentViewController != nil {
                oldContentViewController.willMove(toParentViewController: nil)
                oldContentViewController.view.removeFromSuperview()
                //oldContentViewController.removeFromParentViewController()
                oldContentViewController.didMove(toParentViewController: nil)
            }
            contentViewController.willMove(toParentViewController: self)
            contentViewController.view.frame = contentView.bounds
            //addChildViewController(contentViewController)
            contentView.addSubview(contentViewController.view)
            contentViewController.didMove(toParentViewController: self)
            self.view.layoutIfNeeded()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        buttons = [homeButton,historyButton,addReadingButton]
        for button: UIButton in buttons {
            layout(button)
        }
        homeViewController = HomeViewController(nibName: "HomeViewController", bundle: nil)
        historyViewController = HistoryViewController(nibName: "HistoryViewController", bundle: nil)
        //addReadingViewController = AddReadingViewController(nibName: "AddReadingViewController", bundle: nil)
        addReadingViewController = CreateReadingViewController(nibName: "CreateReadingViewController", bundle: nil)
        viewControllers = [homeViewController, historyViewController ,addReadingViewController]
        //buttons[selected].isSelected = true
        tabButtonDidSelect(buttons[selected])
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tabButtonDidSelect(_ tabButton: UIButton) {
        let previous = selected
        buttons[previous].tintColor = UIColor.darkGray
        //buttons[previous].isSelected = false
        buttons[tabButton.tag].tintColor = Styles.lightBlue
        //buttons[tabButton.tag].isSelected = true
        contentViewController = viewControllers[tabButton.tag]
        selected = tabButton.tag
    }
    fileprivate func layout(_ button: UIButton) {
        let iw = button.imageView!.frame.size.width
        let tw = button.titleLabel!.frame.size.width
        button.imageEdgeInsets = UIEdgeInsetsMake(0, (tw +  iw)/2, 18.0, 0)
        button.tintColor = .darkGray
   }
    @IBAction func onTabButtonTap(_ sender: UIButton) {
        tabButtonDidSelect(sender)
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
