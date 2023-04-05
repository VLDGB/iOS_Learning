//
//  UserResponse.swift
//  iOS_Learning
//
//  Created by Vlad_Rosca on 27.03.2023.
//

import Foundation.NSDate

struct UserResponse: Decodable {
    let email: String
    let password: String
    let name: String
    let avatarImageURL: String
    let role: String
    let id: Int
    let creationAt: Date
    let updatedAt: Date
    
    private enum CodingKeys: String, CodingKey {
        case email
        case password
        case name
        case avatarImageURL = "avatar"
        case role
        case id
        case creationAt
        case updatedAt
    }
}
