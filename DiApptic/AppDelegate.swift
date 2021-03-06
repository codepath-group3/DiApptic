//
//  AppDelegate.swift
//  DiApptic
//
//  Created by Faheem Hussain on 11/13/16.
//  Copyright © 2016 Faheem Hussain. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, LoginDelegate, LogoutDelegate {

    var window: UIWindow?
    var loginViewController: LoginViewController!
    var tabbarViewController: TabbarController!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Parse.setApplicationId("cuRMkMTRwxGTYVofphrR5ROWEBVJIF8pYYyTLcM3", clientKey: "BFkrS2bmejYuP5895kBffPpjI3JJFpPIfjn0ZHHG")
        tabbarViewController = TabbarController(nibName: "TabbarController", bundle: nil)
        loginViewController = LoginViewController(nibName: "LoginViewController", bundle: nil)
        loginViewController.delegate = self
        //let newEnterNameController = LoginViewController(nibName: "LoginViewController", bundle: nil)
        //self.navigationController.pushViewController(newEnterNameController, animated: true)
        //window?.rootViewController = newEnterNameController
        
        //let profileScreenViewController = ProfileScreenViewController(nibName: "ProfileScreenViewController", bundle: nil)
        //self.navigationController.pushViewController(newEnterNameController, animated: true)
        //window?.rootViewController = profileScreenViewController

       // window?.rootViewController = LoginViewController(nibName: "LoginViewController", bundle: nil)
        let currentUser = PFUser.current()
        if currentUser != nil {
            tabbarViewController.delegate = self;
            window?.rootViewController = tabbarViewController
        } else {
            window?.rootViewController = loginViewController
        }
        //window?.rootViewController = loginViewController
        return true
    }
    func didLogin() {
        window?.rootViewController = tabbarViewController
    }
    
    func didLogout() {
       PFUser.logOut()
       window?.rootViewController = loginViewController
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

