//
//  User.swift
//  iOS_Learning
//
//  Created by Vlad_Rosca on 27.03.2023.
//

import Foundation

struct User : Codable {
    let email: String
    let name: String
    let avatar: String
    let role: String
    let id: Int
    
    init(_ signUpResponse: SignUpResponse) {
        self.email = signUpResponse.email
        self.name = signUpResponse.name
        self.avatar = signUpResponse.avatar
        self.role = signUpResponse.role
        self.id = signUpResponse.id
    }
}
