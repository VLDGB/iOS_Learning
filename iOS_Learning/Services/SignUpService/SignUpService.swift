//
//  SignUpService.swift
//  iOS_Learning
//
//  Created by Vlad_Rosca on 27.03.2023.
//

import Foundation

protocol SignUpService {
    func signUp(name: String, email: String, password: String, complition: @escaping (AuthenticationResponse) -> Void)
}
