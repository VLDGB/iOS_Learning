//
//  LoginRequestBuilder.swift
//  iOS_Learning
//
//  Created by Vlad_Rosca on 04.04.2023.
//

import Foundation.NSData
import Resolver

struct LoginRequestBuilder {
    
    static let standard = LoginRequestBuilder()
    
    private let encoder = JSONEncoder()
    private let requestBuilder = RequestBuilder.standard
    
    private init() {}
    
    func build(email: String, password: String) throws -> URLRequest {
        let payload = LoginPayload(email: email, password: password)
        let url = URLProvider.shared.loginURL
        let request = try requestBuilder.build(url: url, httpMethod: .post, payload: payload)
        
        return request
    }
}


