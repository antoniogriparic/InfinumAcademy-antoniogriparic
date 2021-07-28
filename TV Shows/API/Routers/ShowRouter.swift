//
//  ShowRouter.swift
//  TV Shows
//
//  Created by Infinum on 26.07.2021..
//

import Foundation
import Alamofire

enum ShowRouter : URLRequestConvertible {
    
    case shows
    
    var path : String {
        switch self {
        case .shows:
            return "/shows"
        }
    }
    
    var method : HTTPMethod {
        switch self {
        case .shows:
            return .get
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let headers = SessionManager.shared.authInfo?.headers ?? [:]
        let urlRequest = try URLRequest(url: Constants.API.baseURL + path, method: method , headers: HTTPHeaders(headers))
        return urlRequest
    }
    
}
