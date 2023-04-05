//
//  SignUpManager.swift
//  iOS_Learning
//
//  Created by Vlad_Rosca on 03.04.2023.
//

import Resolver

class SignUpManager: SignUpManagerProtocol {
    
    @Injected private var signUpService: SignUpServiceProtocol
    @Injected private var storageService: StorageServiceProtocol
    
    func signUp(name: String, email: String, password: String, completion: @escaping (Result<Void, ErrorCause>) -> Void) {
        signUpService.signUp(name: name, email: email, password: password) { result in
            switch result {
            case .success(let user):
                let saveUserResponse = self.storageService.save(user: user)
                completion(saveUserResponse)
            case .failure(let errorCause):
                completion(.failure(errorCause))
            }
        }
    }
}
