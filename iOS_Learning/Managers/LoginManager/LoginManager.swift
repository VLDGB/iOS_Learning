//
//  LoginManager.swift
//  iOS_Learning
//
//  Created by Vlad_Rosca on 02.04.2023.
//

import Resolver

class LoginManager: LoginManagerProtocol {
    
    @Injected private var loginService: LoginServiceProtocol
    @Injected private var userService: UserServiceProtocol
    @Injected private var storageService: StorageServiceProtocol
            
    func login(email: String, password: String, completion: @escaping (Result<Void, ErrorCause>) -> Void) {
        loginService.login(email: email, password: password) { [weak self] result in
            switch result {
            case .success(let tokens):
                self?.storageService.save(accessToken: tokens.accessToken)
                self?.storageService.save(refreshToken: tokens.refreshToken)
                self?.getAndSaveCurrentUser(completion: completion)
            case .failure(let errorCause):
                completion(.failure(errorCause))
            }
        }
    }
    
    private func getAndSaveCurrentUser(completion: @escaping (Result<Void, ErrorCause>) -> Void) {
        userService.getCurrentUser { [weak self] result in
            switch result {
            case .success(let user):
                self?.saveCurrentUser(user: user, completion: completion)
            case .failure(let errorCause):
                completion(.failure(errorCause))
            }
        }
    }
    
    private func saveCurrentUser(user: User, completion: @escaping (Result<Void, ErrorCause>) -> Void) {
        let saveUserResult = storageService.save(user: user)
        completion(saveUserResult)
    }
}
