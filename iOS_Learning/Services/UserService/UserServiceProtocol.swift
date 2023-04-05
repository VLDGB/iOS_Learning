//
//  UserService.swift
//  iOS_Learning
//
//  Created by Vlad_Rosca on 30.03.2023.
//

protocol UserServiceProtocol {
    
    func getCurrentUser(completion: @escaping (Result<User, ErrorCause>) -> Void)
}
