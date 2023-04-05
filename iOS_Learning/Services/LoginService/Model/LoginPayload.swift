//
//  LoginPayload.swift
//  iOS_Learning
//
//  Created by Vlad_Rosca on 23.03.2023.
//

import Foundation

struct LoginPayload : Encodable {
    let email: String
    let password: String
}
