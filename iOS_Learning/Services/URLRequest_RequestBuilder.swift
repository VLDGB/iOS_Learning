//
//  URLRequest_buildRequest.swift
//  iOS_Learning
//
//  Created by Vlad_Rosca on 26.03.2023.
//

import Foundation

extension URLRequest {
    
    struct RequestBuilder {
        
        private static let encoder = JSONEncoder()
        private static let tokenHandler = UserDefaults.TokenHandler.self
        
        
        static func build<T: Encodable>(url: URL, httpMethod: String, payload: T) -> URLRequest? {
            let body = try? encoder.encode(payload)
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = httpMethod
            request.httpBody = body
            
            return request
        }
        
        static func build(url: URL, httpMethod: String, useAccessToken: Bool) -> URLRequest?  {
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = httpMethod
            
            if useAccessToken {
                guard let accessToken = UserDefaults.TokenHandler.getAccessToken() else {
                    return nil
                }
                
                request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            }
            
            return request
        }
    }
}
