//
//  URLRequest_buildRequest.swift
//  iOS_Learning
//
//  Created by Vlad_Rosca on 26.03.2023.
//

import Foundation

extension URLRequest {
    
    struct RequestBuilder {
        
        static let encoder = JSONEncoder()
        
        static func build<T: Encodable>(url: URL, httpMethod: String, payload: T ) -> URLRequest? {
            let body = try? encoder.encode(payload)
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = httpMethod
            request.httpBody = body
            
            return request
        }
    }
}
