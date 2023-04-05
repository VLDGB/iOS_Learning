//
//  StorageServiceProtocol.swift
//  iOS_Learning
//
//  Created by Vlad_Rosca on 04.04.2023.
//

protocol StorageServiceProtocol {
    
    func save(user: User) -> Result<Void, ErrorCause>
    func save(accessToken: String)
    func getAccessToken() -> String?
    func save(refreshToken: String)
    func getRefreshToken() -> String?
}
