//
//  LoginViewController.swift
//  TV Shows
//
//  Created by Infinum on 12.07.2021..
//

import UIKit


final class LoginViewController : UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var rememberMeButton: UIButton!
    @IBOutlet private weak var registerButton: UIButton!
    @IBOutlet private weak var visibleButton: UIButton!
    
    // MARK: - Properties
    
    private var rememberMeButtonState = false
    private var visibleButtonState = false
    
    // MARK: - Lifecycle methods -
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupUI()
        
    }
    
    // MARK: - Actions

    @IBAction func usernameTextFieldHandler(_ sender: Any) {
        LoginAndRegisterHandler()
    }
    
    @IBAction func passwordTextFieldHandler(_ sender: Any) {
        if passwordTextField.hasText {
            visibleButton.isHidden = false
        }
        else {
            visibleButton.isHidden = true
        }
        
        LoginAndRegisterHandler()
    }
    
    @IBAction func rememberMeButtonHandler(_ sender: Any) {
        if rememberMeButtonState {
            rememberMeButton.setBackgroundImage(UIImage(named: "ic-checkbox-unselected"), for: .normal)
            rememberMeButtonState = false
        }
        else {
            rememberMeButton.setBackgroundImage(UIImage(named: "ic-checkbox-selected"), for: .normal)
            rememberMeButtonState = true
        }
        
    }
    
    @IBAction func visibleButtonHandler(_ sender: Any) {
        if visibleButtonState {
            visibleButton.setBackgroundImage(UIImage(named: "ic-invisible"), for: .normal)
            visibleButtonState = false
            passwordTextField.isSecureTextEntry = true
        }
        else {
            visibleButton.setBackgroundImage(UIImage(named: "ic-visible"), for: .normal)
            visibleButtonState = true
            passwordTextField.isSecureTextEntry = false
        }
        
    }
    
    
}


private extension LoginViewController {
    
    func createPlaceholderAttributedString(text: String) -> NSAttributedString {
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.7)
        ]
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    func setUpButtons() -> Void {
        loginButton.layer.cornerRadius = 21.5
        loginButton.alpha = 0.5
        loginButton.isEnabled = false
        registerButton.isEnabled = false
        visibleButton.isHidden = true
    }
    
    func setUpTextFields() -> Void {
        usernameTextField.attributedPlaceholder = createPlaceholderAttributedString(text: "Email")
        passwordTextField.attributedPlaceholder = createPlaceholderAttributedString(text: "Password")
        passwordTextField.isSecureTextEntry = true
    }
    
    func setupUI() -> Void {
        setUpButtons()
        setUpTextFields()
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func LoginAndRegisterHandler() -> Void {
        if usernameTextField.hasText && passwordTextField.hasText && isValidEmail(usernameTextField.text ?? "") {
            loginButton.isEnabled = true
            loginButton.alpha = 1.0
            registerButton.isEnabled = true
        }
        else {
            loginButton.isEnabled = false
            loginButton.alpha = 0.5
            registerButton.isEnabled = false
        }
    }
    
    
}
