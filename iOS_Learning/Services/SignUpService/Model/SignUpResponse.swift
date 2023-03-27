//
//  SignUpResponse.swift
//  iOS_Learning
//
//  Created by Vlad_Rosca on 27.03.2023.
//

import Foundation

struct SignUpResponse: Decodable {
    let email: String
    let password: String
    let name: String
    let avatar: String
    let role: String
    let id: Int
    let creationAt: String
    let updatedAt: String
}
