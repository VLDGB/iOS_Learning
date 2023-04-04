//
//  SignUpRequestBuilder.swift
//  iOS_Learning
//
//  Created by Vlad_Rosca on 04.04.2023.
//

import Foundation.NSJSONSerialization

struct SignUpRequestBuilder {
    
    static let standard = SignUpRequestBuilder()
    
    private let encoder = JSONEncoder()
    private let requestBuilder = RequestBuilder.standard
    
    private init() {}
    
    func build(name: String, email: String, password: String) throws -> URLRequest {
        let payload = SignUpPayload(
            name: name,
            email: email,
            password: password,
            // to be refactored
            avatar: "https://api.lorem.space/image/face?w=640&h=480&r=867"
        )
        let url = URLProvider.shared.signUpURL
        let request = try requestBuilder.build(url: url, httpMethod: .post, payload: payload)
        
        return request
    }
}
