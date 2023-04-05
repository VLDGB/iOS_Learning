//
//  UNSignUpService.swift
//  iOS_Learning
//
//  Created by Vlad_Rosca on 27.03.2023.
//

import Foundation.NSJSONSerialization
import Resolver

class SignUpService: SignUpServiceProtocol {
    
    @Injected private var restClient: RestClientProtocol
    
    private let decoder = JSONDecoder().ISO8601DateDecodingStrategySetup()
    
    func signUp(name: String, email: String, password: String, completion: @escaping (Result<User, ErrorCause>) -> Void) {
        do {
            let request = try SignUpRequestBuilder.standard.build(name: name, email: email, password: password)
            restClient.send(urlRequest: request) { [weak self] result in
                switch result {
                case .success(let data):
                    self?.decodeUserResponse(data: data, completion: completion)
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } catch {
            completion(.failure(.technical))
        }
    }
    
    private func decodeUserResponse(data: Data?, completion: @escaping (Result<User, ErrorCause>) -> Void) {
        guard let data = data else {
            completion(.failure(.technical))
            return
        }
        
        if let response = try? decoder.decode(UserResponse.self, from: data) {
            let user  = User(response)
            completion(.success(user))
        } else {
            completion(.failure(.technical))
        }
    }
}
