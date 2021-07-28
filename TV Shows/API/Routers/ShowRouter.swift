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
    case listReviews(showId : String)
    
    var path : String {
        switch self {
        case .shows:
            return "/shows"
        case .listReviews(let showId):
            return "/shows/" + showId + "/reviews"
        }
    }
    
    var method : HTTPMethod {
        switch self {
        case .shows, .listReviews(_ ):
            return .get
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let headers = SessionManager.shared.authInfo?.headers ?? [:]
        let urlRequest = try URLRequest(url: Constants.API.baseURL + path, method: method , headers: HTTPHeaders(headers))
        return urlRequest
    }
    
}
