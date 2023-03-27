//
//  LoginService.swift
//  iOS_Learning
//
//  Created by Vlad_Rosca on 23.03.2023.
//

import Foundation

protocol LoginService {
    
    func login(email: String, password: String, complition: @escaping (AuthenticationResponse) -> Void)
    func saveCurrentUser(complition: @escaping (AuthenticationResponse) -> Void)
}
