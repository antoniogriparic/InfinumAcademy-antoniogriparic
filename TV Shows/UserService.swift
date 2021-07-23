//
//  UserService.swift
//  TV Shows
//
//  Created by Infinum on 23.07.2021..
//

import Foundation
import Alamofire
import SVProgressHUD

final class UserService {
    
    func registerUserWith(email : String , password : String) {
        
        SVProgressHUD.show()
        
        AF
            .request(UserRouter.register(email: email, password: password))
            .validate()
            .responseDecodable(of: UserResponse.self) { response in
                switch response.result {
                case .success(let userResponse):
                    print(userResponse)
                    self.loginUserWith(email: email , password : password)
                case .failure(let error):
                    SVProgressHUD.showError(withStatus: "Error")
                    print("Registration Error : \(error)")
                }
            }
    }
    
    func loginUserWith(email : String, password : String) {
        
        SVProgressHUD.show()
        
        AF
            .request(UserRouter.login(email: email, password: password))
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
