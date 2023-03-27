//
//  URLBuilder.swift
//  iOS_Learning
//
//  Created by Vlad_Rosca on 24.03.2023.
//

import Foundation

class URLProvider {
    static let shared = URLProvider()
    private var baseURL: URL! = URL(string: "https://api.escuelajs.co/api/v1/")
    
    let loginURL: URL
    let signUpURL: URL
    let profileURL: URL
    
    private init() {
        loginURL = baseURL.appendingPathComponent("auth/login")
        signUpURL = baseURL.appendingPathComponent("users")
        profileURL = baseURL.appendingPathComponent("auth/profile")
    }
}
