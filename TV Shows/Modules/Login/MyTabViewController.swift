//
//  MyTabViewController.swift
//  TV Shows
//
//  Created by Infinum on 02.08.2021..
//

import UIKit

final class MyTabViewController: UITabBarController {
    
    var notificationToken: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpLogOutNotification()
        
        let storyboard = UIStoryboard(name: "Home", bundle: nil)

        let showsViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        showsViewController.usingTopRated = false
        
        let topRatedViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        topRatedViewController.usingTopRated = true
        
        viewControllers = [
            UINavigationController(rootViewController: showsViewController),
            UINavigationController(rootViewController: topRatedViewController)
        ]
        
        tabBar.tintColor = UIColor(red: 0.32, green: 0.21, blue: 0.55, alpha: 1)
        showsViewController.loadViewIfNeeded()
        topRatedViewController.loadViewIfNeeded()
    }
    
    deinit {
        if let token = notificationToken {
            NotificationCenter.default.removeObserver(token)
        }
    }
    
}

private extension MyTabViewController {
    
    func setUpLogOutNotification() {
        notificationToken = NotificationCenter
            .default
            .addObserver(
                forName: NotificationDidLogout,
                object: nil,
                queue: nil,
                using: { [weak self] _ in
                    guard let self = self else { return }
                    let storyboard = UIStoryboard(name: "Login", bundle: nil)
                    let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                    self.navigationController?.setViewControllers([loginViewController], animated: true)
                }
            )
    }
}
