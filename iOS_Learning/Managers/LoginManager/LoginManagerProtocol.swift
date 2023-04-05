//
//  LoginManagerProtocol.swift
//  iOS_Learning
//
//  Created by Vlad_Rosca on 02.04.2023.
//

protocol LoginManagerProtocol {
    
    func login(email: String, password: String, completion: @escaping (Result<Void, ErrorCause>) -> Void)
}
