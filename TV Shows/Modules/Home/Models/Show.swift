//
//  Show.swift
//  TV Shows
//
//  Created by Infinum on 25.07.2021..
//

import Foundation

struct ShowsResponse: Decodable {
    let shows: [Show]
}

struct  Show : Decodable {
    let id: String
    let averageRating : Double?
    let description : String
    let imageUrl : URL?
    let noOfReviews : Int
    let title: String
    
    enum CodingKeys : String , CodingKey {
        case id
        case averageRating = "average_rating"
        case description
        case imageUrl = "image_url"
        case noOfReviews = "no_of_reviews"
        case title
    }
}
