//
//  UNSignUpService.swift
//  iOS_Learning
//
//  Created by Vlad_Rosca on 27.03.2023.
//

import Foundation

class UNSignUpService: SignUpService {
    
    private let restClient = UNRestClient()
    private let decoder = JSONDecoder()
    private let userHandler = UserDefaults.UserHandler.self
    
    func signUp(name: String, email: String, password: String, complition: @escaping (AuthenticationResponse) -> Void) {
        let signUpPayload = SignUpPayload(name: name, email: email, password: password)
        let signUpURL = URLProvider.shared.signUpURL
        guard let request = URLRequest.RequestBuilder.build(url: signUpURL, httpMethod: HttpMethod.post, payload: signUpPayload) else {
            let authenticationResponse = AuthenticationResponse.failure(AuthenticationResponse.Error.unknown)
            complition(authenticationResponse)
            return
        }
        
        restClient.send(urlRequest: request, completion: { result in

            switch result {
            case .success(let unwrappedData):
                do {
                    guard let wrappedData = unwrappedData else {
                        complition(AuthenticationResponse.failure(AuthenticationResponse.Error.unknown))
                        return
                    }
                    
                    let signUpResponse = try self.decoder.decode(SignUpResponse.self, from: wrappedData)
                    let user = User(signUpResponse)
                
                    guard self.userHandler.saveUser(user: user) else {
                        
                        complition(AuthenticationResponse.failure(AuthenticationResponse.Error.failedToSaveUser))
                        return
                    }
                    
                    let authenticationResponse = AuthenticationResponse.success
                    complition(authenticationResponse)
                } catch {
                    
                    let authenticationResponse = AuthenticationResponse.failure(AuthenticationResponse.Error.unknown)
                    complition(authenticationResponse)
                }
            case .failure(let error):
                let authenticationResponse = AuthenticationResponse(error)
                complition(authenticationResponse)
            }
        })
    }
}
