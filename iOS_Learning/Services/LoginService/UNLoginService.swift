//
//  UNLoginService.swift
//  iOS_Learning
//
//  Created by Vlad_Rosca on 23.03.2023.
//

import Foundation

class UNLoginService: LoginService {
    
    private let restClient = UNRestClient()
    private let decoder = JSONDecoder()
    private let tokenHandler = UserDefaults.TokenHandler.self
    private let userHandler = UserDefaults.UserHandler.self

    
    func login(email: String, password: String, complition: @escaping (AuthenticationResponse) -> Void) {
        let loginPayload = LoginPayload(email: email, password: password)
        let loginURL = URLProvider.shared.loginURL
        
        guard let request = URLRequest.RequestBuilder.build(url: loginURL, httpMethod: HttpMethod.post, payload: loginPayload) else {
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
                    
                    let loginResponse = try self.decoder.decode(LoginResponse.self, from: wrappedData)
                    self.saveTokens(
                        accessToken: loginResponse.accessToken,
                        refreshToken: loginResponse.refreshToken
                    )
                    
                    
                    self.saveCurrentUser { saveCurrentUserResponse in
                        complition(saveCurrentUserResponse)
                    }
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
    
    func saveCurrentUser(complition: @escaping (AuthenticationResponse) -> Void) {
        let profileURL = URLProvider.shared.profileURL
        guard let request = URLRequest.RequestBuilder.build(url: profileURL, httpMethod: HttpMethod.get, useAccessToken: true) else {
            let authenticationResponse = AuthenticationResponse.failure(AuthenticationResponse.Error.unknown)
            complition(authenticationResponse)
            return
        }
        
        restClient.send(urlRequest: request) { result in
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
        }
    }
    
    private func saveTokens(accessToken: String, refreshToken: String) {
        tokenHandler.setAccessToken(accessToken: accessToken)
        tokenHandler.setRefreshToken(refreshToken: refreshToken)
    }
}
