//
//  AppDelegate.swift
//  TV Shows
//
//  Created by Infinum on 08.07.2021..
//

import UIKit

@main class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let navigationController = UINavigationController()
        let authInfo: AuthInfo? = KeychainManager.getAuthInfo()
        SessionManager.shared.authInfo = authInfo

        if authInfo != nil {
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            navigationController.viewControllers = [homeViewController]
        } else {
            let storyboard = UIStoryboard(name: "Login", bundle: nil)
            let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            navigationController.viewControllers = [loginViewController]
        }
        
        window?.rootViewController = navigationController
        
        return true
    }
    
}
