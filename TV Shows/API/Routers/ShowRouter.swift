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
    case listReviews(showId: String)
    case publishReview(showId: String, rating: String, comment: String)
    
    var path: String {
        switch self {
        case .shows:
            return "/shows"
        case .listReviews(let showId):
            return "/shows/" + showId + "/reviews"
        case .publishReview:
            return "/reviews"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .shows, .listReviews(_ ):
            return .get
        case .publishReview:
            return .post
        }
    }
    
    var parameters: [String: String] {
        switch self {
        case .shows, .listReviews:
            return ["":""]
        case .publishReview(let showId, let rating, let comment):
            return [
                "rating": rating,
                "comment": comment,
                "show_id": showId
            ]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        switch self {
        case .shows, .listReviews:
            let headers = SessionManager.shared.authInfo?.headers ?? [:]
            let urlRequest = try URLRequest(
                url: Constants.API.baseURL + path,
                method: method ,
                headers: HTTPHeaders(headers))
            return urlRequest
        case .publishReview:
            let headers = SessionManager.shared.authInfo?.headers ?? [:]
            var urlRequest = try URLRequest(
                url: Constants.API.baseURL + path,
                method: method ,
                headers: HTTPHeaders(headers))
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
            return urlRequest
        }
    }
    
}
