//
//  User.swift
//  iOS_Learning
//
//  Created by Vlad_Rosca on 27.03.2023.
//

import Foundation.NSURL

enum User: Codable {
    case email(String)
    case name(String)
    case avatarImageURL(URL?)
    case role(String)
    case id(Int)
    case createdAt(Date)
    
    init(_ userResponse: UserResponse) {
        self = .email(userResponse.email)
        self = .name(userResponse.name)
        self = .role(userResponse.role)
        self = .id(userResponse.id)
        self = .avatarImageURL(URL(string: userResponse.avatarImageURL))
        self = .createdAt(userResponse.creationAt)
    }
}
