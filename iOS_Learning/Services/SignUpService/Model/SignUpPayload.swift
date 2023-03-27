//
//  SignUpPayload.swift
//  iOS_Learning
//
//  Created by Vlad_Rosca on 27.03.2023.
//

import Foundation

struct SignUpPayload: Encodable {
    let name: String
    let email: String
    let password: String
    // in doc avatar is a static image; 
    let avatar: String = "https://api.lorem.space/image/face?w=640&h=480&r=867"
}
