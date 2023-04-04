//
//  LoginService.swift
//  iOS_Learning
//
//  Created by Vlad_Rosca on 23.03.2023.
//

import Foundation.NSJSONSerialization
import Resolver

class LoginService: LoginServiceProtocol {
    
    @Injected private var restClient: RestClientProtocol
    
    private let decoder = JSONDecoder()
    
    func login(
        email: String,
        password: String,
        completion: @escaping (Result<(accessToken: String, refreshToken: String), ErrorCause>) -> Void)
    {
        do {
            let request = try LoginRequestBuilder.standard.build(email: email, password: password)
            restClient.send(urlRequest: request) { [weak self] result in
                switch result {
                case .success(let data):
                    self?.decodeLoginResponse(data: data, completion: completion)
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } catch {
            completion(.failure(.technical))
        }
    }
    
    private func decodeLoginResponse(
        data: Data?,
        completion: @escaping (Result<(accessToken: String, refreshToken: String), ErrorCause>) -> Void)
    {
        guard let data = data else {
            completion(.failure(.technical))
            return
        }
        
        if let response = try? decoder.decode(LoginResponse.self, from: data) {
            let successPayload = (response.accessToken, response.refreshToken)
            
            completion(.success(successPayload))
        } else {
            completion(.failure(.technical))
        }
    }
}

