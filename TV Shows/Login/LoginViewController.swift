//
//  LoginViewController.swift
//  TV Shows
//
//  Created by Infinum on 12.07.2021..
//

import UIKit


final class LoginViewController : UIViewController {
    
    
    @IBOutlet private weak var counterLabel: UILabel!
    @IBOutlet private weak var counterButton: UIButton!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var indicatorButton: UIButton!
    var touchCount = 0
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        touchCount = 0
        counterButton.layer.cornerRadius = 25.0
        indicatorButton.layer.cornerRadius = 25.0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.activityIndicator.stopAnimating()
        }
        
    }
    
    @IBAction func buttonHandler(_ sender: Any) {
        print("Button touched!")
        touchCount += 1
        counterLabel.text = String(touchCount)
        
    }
 
    @IBAction func indicatorController(_ sender: Any) {
        
        if(activityIndicator.isAnimating) {
            activityIndicator.stopAnimating()
            indicatorButton.setTitle("Start Activity Indicator", for: .normal)
        }
        else {
            activityIndicator.startAnimating()
            indicatorButton.setTitle("Stop Activity Indicator", for: .normal)
        }
        
    }
    
    
}
