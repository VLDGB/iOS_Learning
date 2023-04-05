//
//  RequestBuilder.swift
//  iOS_Learning
//
//  Created by Vlad_Rosca on 26.03.2023.
//

import Foundation.NSJSONSerialization
import Resolver

struct RequestBuilder {
    
    @Injected private var storageService: StorageServiceProtocol
    
    static let standard = RequestBuilder()
    
    private let encoder = JSONEncoder()
    
    private init(){}
    
    func build<T: Encodable>(url: URL, httpMethod: HttpMethod, payload: T) throws -> URLRequest {
        let body = try encoder.encode(payload)
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = httpMethod.rawValue
        request.httpBody = body
        
        return request
    }
    
    func build(url: URL, httpMethod: HttpMethod, useAccessToken: Bool = true) throws -> URLRequest  {
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = httpMethod.rawValue
        
        if useAccessToken {
             guard let accessToken = storageService.getAccessToken() else {
                 throw ErrorCause.technical
            }
            
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        return request
    }
}
