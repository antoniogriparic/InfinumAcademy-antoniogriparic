//
//  ProfileDetailsViewController.swift
//  TV Shows
//
//  Created by Infinum on 31.07.2021..
//

import UIKit
import Kingfisher

final class ProfileDetailsViewController: UIViewController {
    
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var profilePhoto: UIImageView!
    @IBOutlet private weak var changeProfilePhotoButton: UIButton!
    @IBOutlet private weak var logoutButton: UIButton!
    
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func changeProfilePhotoButtonHandler() {
        
    }
    
    @IBAction func logoutButtonHandler() {
        
    }
    
    func setupUI() {
        
        logoutButton.layer.cornerRadius = 21.5
        profilePhoto.layer.masksToBounds = true
        profilePhoto.layer.cornerRadius = profilePhoto.bounds.width / 2
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Close",
            style: .plain,
            target: self,
            action: #selector(didSelectClose)
        )
        navigationItem.title = "My Account"
        
        guard let user = user else { showAlter(title: "something went wrong!") ; return }
        
        emailLabel.text = user.email
        
        if let userImageUrl = user.imageUrl {
            let placeholder = UIImage(named: "ic-profile-placeholder")
            profilePhoto.kf.setImage(with: userImageUrl, placeholder: placeholder)
        }
    }
    
    @objc private func didSelectClose() {
        dismiss(animated: true, completion: nil)
    }
    
}
