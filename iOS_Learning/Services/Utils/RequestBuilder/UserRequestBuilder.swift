//
//  UserRequestBuilder.swift
//  iOS_Learning
//
//  Created by Vlad_Rosca on 04.04.2023.
//

import Foundation.NSJSONSerialization
import Resolver

struct UserReqestBuilder {
    
    @Injected private var storageService: StorageServiceProtocol
    
    static let shared = UserReqestBuilder()
    
    private let encoder = JSONEncoder()
    private let requestBuilder = RequestBuilder.standard
    
    private init() {}
    
    func build() throws -> URLRequest {
        let url = URLProvider.shared.profileURL
        let request = try requestBuilder.build(url: url, httpMethod: .get)
        
        return request
    }
}
