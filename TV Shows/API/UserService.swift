//
//  UserService.swift
//  TV Shows
//
//  Created by Infinum on 23.07.2021..
//

import Foundation
import Alamofire

final class UserService {
    
    func registerUserWith(email: String, password: String ,completion: @escaping (DataResponse<UserResponse, AFError>) -> Void) {
        
        AF
            .request(UserRouter.register(email: email, password: password))
            .validate()
            .responseDecodable(of: UserResponse.self) { dataResponse in
                SessionManager.shared.storeAuthInfo(headers: dataResponse.response?.headers.dictionary)
                completion(dataResponse)
            }
    }
    
    func loginUserWith(email: String, password: String,completion: @escaping (DataResponse<UserResponse, AFError>) -> Void) {
                
        AF
            .request(UserRouter.login(email: email, password: password))
            .validate()
            .responseDecodable(of: UserResponse.self) { dataResponse in
                SessionManager.shared.storeAuthInfo(headers: dataResponse.response?.headers.dictionary)
                completion(dataResponse)
            }
    }
    
    
}
