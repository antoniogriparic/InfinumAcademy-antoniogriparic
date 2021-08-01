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
    case user
    
    var path : String {
        switch self {
        case .login:
            return "/users/sign_in"
        case .register:
            return "/users"
        case .user:
            return "/users/me"
        }
    }
    
    var method : HTTPMethod {
        switch self {
        case .login, .register:
            return .post
        case .user:
            return .get
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
        case .user:
            return ["":""]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let headers = SessionManager.shared.authInfo?.headers ?? [:]
        var urlRequest = try URLRequest(url: Constants.API.baseURL + path, method: method , headers: HTTPHeaders(headers))
        
        switch self {
        case .login, .register:
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        case .user:
            break
        }
        
        return urlRequest
    }
    
}
