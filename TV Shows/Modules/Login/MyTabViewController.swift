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
        
        self.tabBar.tintColor = UIColor(red: 0.32, green: 0.21, blue: 0.55, alpha: 1)
        
        if let tabBarItem1 = self.tabBar.items?[0] {
            tabBarItem1.title = "Shows"
            tabBarItem1.image = UIImage(named: "ic-show-deselected")
            tabBarItem1.selectedImage = UIImage(named: "ic-show-selected")
        }
        
        if let tabBarItem2 = self.tabBar.items?[1] {
            tabBarItem2.title = "Top Rated"
            tabBarItem2.image = UIImage(named: "ic-top-rated-deselected")
            tabBarItem2.selectedImage = UIImage(named: "ic-top-rated-selected")
        }
        
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
