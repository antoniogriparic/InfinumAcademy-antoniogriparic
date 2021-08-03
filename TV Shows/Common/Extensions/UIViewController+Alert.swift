//
//  UIViewController+Alert.swift
//  TV Shows
//
//  Created by Infinum on 01.08.2021..
//

import UIKit

extension UIViewController {
    
    func showAlter(title: String) {
        let alertController = UIAlertController(title: title, message: "", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            alertController.dismiss(animated: true)
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true)
    }
    
}
