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
    
    func registerUserWith(email: String, password: String ,completion: @escaping (DataResponse<UserResponse, AFError>) -> Void) {
        
        AF
            .request(UserRouter.register(email: email, password: password))
            .validate()
            .responseDecodable(of: UserResponse.self) { response in
                completion(response)
            }
    }
    
    func loginUserWith(email: String, password: String,completion: @escaping (DataResponse<UserResponse, AFError>) -> Void) {
        
        AF
            .request(UserRouter.login(email: email, password: password))
            .validate()
            .responseDecodable(of: UserResponse.self) { response in
                completion(response)
            }
    }
    
    
}
