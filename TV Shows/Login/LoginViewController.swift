//
//  LoginViewController.swift
//  TV Shows
//
//  Created by Infinum on 12.07.2021..
//

import UIKit
import SVProgressHUD
import Alamofire


final class LoginViewController : UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var rememberMeButton: UIButton!
    @IBOutlet private weak var registerButton: UIButton!
    @IBOutlet private weak var visibleButton: UIButton!
    @IBOutlet private weak var scrollView: UIScrollView!
    
    // MARK: - Properties
    
    private var rememberMeButtonEnabled = false
    private var visibleButtonEnabled = false
    
    // MARK: - Lifecycle methods -
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupUI()
        
    }
    
    // MARK: - Actions
    
    @IBAction func usernameTextFieldHandler() {
        loginAndRegisterHandler()
    }
    
    @IBAction func passwordTextFieldHandler() {
        if passwordTextField.hasText {
            visibleButton.isHidden = false
        }
        else {
            visibleButton.isHidden = true
        }
        loginAndRegisterHandler()
    }
    
    @IBAction func rememberMeButtonHandler() {
        if rememberMeButtonEnabled {
            rememberMeButton.setImage(UIImage(named: "ic-checkbox-unselected"), for: .normal)
        }
        else {
            rememberMeButton.setImage(UIImage(named: "ic-checkbox-selected"), for: .normal)
        }
        rememberMeButtonEnabled.toggle()
    }
    
    @IBAction func visibleButtonHandler() {
        if visibleButtonEnabled {
            visibleButton.setBackgroundImage(UIImage(named: "ic-invisible"), for: .normal)
            passwordTextField.isSecureTextEntry = true
        }
        else {
            visibleButton.setBackgroundImage(UIImage(named: "ic-visible"), for: .normal)
            passwordTextField.isSecureTextEntry = false
        }
        visibleButtonEnabled.toggle()
    }
    
    @IBAction func loginButtonHandler() {
        guard let email = usernameTextField.text, let password = passwordTextField.text else { return }
        loginUserWith(email: email, password: password)
        navigateToHomeScreen()
    }
    
    @IBAction func registerButtonHandler() {
        guard let email = usernameTextField.text, let password = passwordTextField.text else { return }
        registerUserWith(email: email, password: password)
        navigateToHomeScreen()
    }
    
    
}


private extension LoginViewController {
    
    func createPlaceholderAttributedString(text: String) -> NSAttributedString {
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.7)
        ]
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    func setUpButtons() {
        loginButton.layer.cornerRadius = 21.5
        loginButton.alpha = 0.5
        loginButton.isEnabled = false
        registerButton.isEnabled = false
        visibleButton.isHidden = true
    }
    
    func setUpTextFields() {
        usernameTextField.attributedPlaceholder = createPlaceholderAttributedString(text: "Email")
        passwordTextField.attributedPlaceholder = createPlaceholderAttributedString(text: "Password")
        passwordTextField.isSecureTextEntry = true
    }
    
    func setupUI() {
        setUpButtons()
        setUpTextFields()
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardDidShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardDidHideNotification, object: nil)
        navigationController?.isNavigationBarHidden = true
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func loginAndRegisterHandler(){
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
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue.height

        if notification.name == UIResponder.keyboardDidHideNotification {
            scrollView.contentInset = .zero
        } else if notification.name == UIResponder.keyboardDidShowNotification {
            if UIScreen.main.bounds.height - loginButton.frame.maxY > keyboardScreenEndFrame {
                return
            }
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardScreenEndFrame, right: 0)

            DispatchQueue.main.async {
                self.scrollView.setContentOffset(CGPoint(x: 0, y: 188), animated: true)
            }
            scrollView.scrollIndicatorInsets = scrollView.contentInset
        }
    }
    
    func navigateToHomeScreen() {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
        navigationController?.pushViewController(homeViewController, animated: true)
    }
    
    
}


private extension LoginViewController {
    func registerUserWith(email : String , password : String) {
        
        SVProgressHUD.show()
        
        let parametars: [String: String] = [
            "password" : password,
            "email" : email,
            "password_confirmation" : password
        ]
        
        AF
            .request(
                "https://tv-shows.infinum.academy/users",
                method: .post,
                parameters: parametars,
                encoder: JSONParameterEncoder.default
            )
            .validate()
            .responseDecodable(of: UserResponse.self) { response in
                switch response.result {
                case .success(let userResponse):
                    print(userResponse)
                    self.loginUserWith(email: email , password : password)
                case .failure(let error):
                    SVProgressHUD.showError(withStatus: "Error")
                    print("Error : \(error)")
                }
            }
    }
    
    func loginUserWith(email : String, password : String) {
        
        SVProgressHUD.show()
        
        let parametars : [String: String] = [
            "email" : email,
            "password" : password
        ]
        
        AF
            .request(
                "https://tv-shows.infinum.academy/users/sign_in",
                method: .post,
                parameters: parametars,
                encoder: JSONParameterEncoder.default
            )
            .validate()
            .responseDecodable(of: UserResponse.self) { [weak self] response in
                switch response.result {
                case .success(let userResponse):
                    let headers = response.response?.headers.dictionary ?? [:]
                    self?.handleSuccesfulLogin(user: userResponse.user, headers: headers)
                case .failure(let error):
                    print(error)
                    SVProgressHUD.showError(withStatus: "Error")
                }
            }
    }
    
    func handleSuccesfulLogin(user: User, headers: [String: String]) {
        guard let authInfo = try? AuthInfo(headers: headers) else {
            SVProgressHUD.showError(withStatus: "Missing Headers")
            return
        }
        print(authInfo)
        SVProgressHUD.showSuccess(withStatus: "Success")
    }
    
    
}
