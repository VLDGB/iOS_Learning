//
//  UserService.swift
//  iOS_Learning
//
//  Created by Vlad_Rosca on 30.03.2023.
//

import Foundation.NSJSONSerialization
import Resolver

class UserService: UserServiceProtocol {
    
    @Injected private var restClient: RestClientProtocol
    
    private let decoder = JSONDecoder().ISO8601DateDecodingStrategySetup()
    
    func getCurrentUser(completion: @escaping (Result<User, ErrorCause>) -> Void) {
        do {
            let request = try UserReqestBuilder.shared.build()
            
            restClient.send(urlRequest: request) { [weak self] result in
                switch result {
                case .success(let data):
                    self?.decodeUserResponse(data: data, completion: completion)
                case .failure(let error):
                    let errorCause = ErrorCause(error)
                    completion(.failure(errorCause))
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
