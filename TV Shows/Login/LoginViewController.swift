//
//  LoginViewController.swift
//  TV Shows
//
//  Created by Infinum on 12.07.2021..
//

import UIKit

class LoginViewController : UIViewController {
    
    
    var touchCount : Int = 0
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var indicatorButton: UIButton!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        touchCount = 0
        button.layer.cornerRadius = 25.0
        indicatorButton.layer.cornerRadius = 25.0
        activityIndicator.stopAnimating() //napravi asinkrono 3 sekunde do stopa! i PR!
        
    }
    
    @IBAction func buttonHandler(_ sender: Any) {
        print("Button touched!")
        touchCount += 1
        self.label.text = String(touchCount)
        
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