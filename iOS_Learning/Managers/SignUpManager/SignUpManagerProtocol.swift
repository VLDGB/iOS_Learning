//
//  SignUpManagerProtocol.swift
//  iOS_Learning
//
//  Created by Vlad_Rosca on 03.04.2023.
//

protocol SignUpManagerProtocol {
    
    func signUp(name: String, email: String, password: String, completion: @escaping (Result<Void, ErrorCause>) -> Void)
}
