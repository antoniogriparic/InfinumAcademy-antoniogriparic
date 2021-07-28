//
//  ShowService.swift
//  TV Shows
//
//  Created by Infinum on 26.07.2021..
//

import Foundation
import Alamofire

final class ShowService {
    
    func fetchShows(completion: @escaping (DataResponse<ShowsResponse, AFError>) -> Void) {
        
        AF
            .request(ShowRouter.shows)
            .validate()
            .responseDecodable(of: ShowsResponse.self) { dataResponse in
                completion(dataResponse)
            }
    }
    
    func fetchReviewsList(showId: String, completion: @escaping (DataResponse<ReviewResponse, AFError>) -> Void) {
        AF
            .request(ShowRouter.listReviews(showId: showId))
            .validate()
            .responseDecodable(of: ReviewResponse.self) { dataResponse in
                completion(dataResponse)
            }
    }
    
}
