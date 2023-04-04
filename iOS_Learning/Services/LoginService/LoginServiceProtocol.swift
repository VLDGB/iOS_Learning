//
//  LoginService.swift
//  iOS_Learning
//
//  Created by Vlad_Rosca on 23.03.2023.
//

protocol LoginServiceProtocol {
    
    func login(email: String,
               password: String,
               completion: @escaping (Result<(accessToken: String, refreshToken: String), ErrorCause>) -> Void)
}
