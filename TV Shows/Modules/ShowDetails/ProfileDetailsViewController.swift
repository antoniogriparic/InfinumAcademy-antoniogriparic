//
//  ProfileDetailsViewController.swift
//  TV Shows
//
//  Created by Infinum on 31.07.2021..
//

import UIKit
import Kingfisher

let NotificationDidLogout = Notification.Name(rawValue: "NotificationDidLogout")

final class ProfileDetailsViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var profilePhoto: UIImageView!
    @IBOutlet private weak var changeProfilePhotoButton: UIButton!
    @IBOutlet private weak var logoutButton: UIButton!
    
    // MARK: - Properties
    
    var user: User?
    private let imagePicker = UIImagePickerController()
    private let userService = UserService()
    
    // MARK: - Lifecycle Methods -

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        setupUI()
    }
    
    // MARK: - Actions
    
    @IBAction func changeProfilePhotoButtonHandler() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
                
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func logoutButtonHandler() {
        dismiss(animated: true) {
            KeychainManager.removeUserInfo()
            SessionManager.shared.authInfo = nil
            let notification = Notification(name: NotificationDidLogout)
            NotificationCenter.default.post(notification)
        }
    }
    
}

private extension ProfileDetailsViewController {
    
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

// MARK: - Image Picker Delegate

extension ProfileDetailsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profilePhoto.contentMode = .scaleAspectFit
            profilePhoto.image = pickedImage
            userService.storeImage(pickedImage) { dataResponse in
                switch dataResponse.result{
                case .success:
                    break
                case .failure(let error):
                    print(error)
                    self.showAlter(title: "Failed to upload profile photo!")
                }
            }
        }
            
        dismiss(animated: true, completion: nil)
    }
        
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
