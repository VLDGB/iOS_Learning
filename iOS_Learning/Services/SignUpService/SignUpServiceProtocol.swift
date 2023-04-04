//
//  SignUpService.swift
//  iOS_Learning
//
//  Created by Vlad_Rosca on 27.03.2023.
//

import Foundation

protocol SignUpServiceProtocol {
    
    func signUp(name: String, email: String, password: String, completion: @escaping (Result<User, ErrorCause>) -> Void)
}
