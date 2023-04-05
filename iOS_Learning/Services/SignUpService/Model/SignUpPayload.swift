//
//  SignUpPayload.swift
//  iOS_Learning
//
//  Created by Vlad_Rosca on 27.03.2023.
//

struct SignUpPayload: Encodable {
    let name: String
    let email: String
    let password: String
    let avatar: String
}
