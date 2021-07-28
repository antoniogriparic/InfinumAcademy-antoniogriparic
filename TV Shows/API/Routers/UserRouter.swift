//
//  UserRouter.swift
//  TV Shows
//
//  Created by Infinum on 23.07.2021..
//

import Foundation
import Alamofire

enum UserRouter : URLRequestConvertible {
    
    case login(email: String, password: String)
    case register(email: String, password: String)
    
    var path : String {
        switch self {
        case .login:
            return "/users/sign_in"
        case .register:
            return "/users"
        }
    }
    
    var method : HTTPMethod {
        switch self {
        default :
            return .post
        }
    }
    
    var parameters : [String: String] {
        switch self {
        case .login(let email, let password):
            return [
                "email" : email,
                "password" : password
            ]
        case .register(let email, let password):
            return [
                "email" : email,
                "password" : password,
                "password_confirmation" : password
            ]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let headers = SessionManager.shared.authInfo?.headers ?? [:]
        var urlRequest = try URLRequest(url: Constants.API.baseURL + path, method: method , headers: HTTPHeaders(headers))
        urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        return urlRequest
    }
    
    
}
