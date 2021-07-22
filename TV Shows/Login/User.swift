//
//  User.swift
//  TV Shows
//
//  Created by Infinum on 22.07.2021..
//

import Foundation

struct UserResponse : Codable {
    
    let user : User
    
}

struct User : Codable {
    
    let id : String
    let email : String
    let imageUrl : String?
    
    enum CodingKeys: String , CodingKey {
        case id
        case email
        case imageUrl = "image_url"
    }
}

