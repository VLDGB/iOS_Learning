//
//  UserDefaultsStorageService.swift
//  iOS_Learning
//
//  Created by Vlad_Rosca on 04.04.2023.
//
import Foundation.NSUserDefaults

class UserDefaultsStorageService: StorageServiceProtocol {
    
    private let userDefaults = UserDefaults.standard
    private let encoder = JSONEncoder()

    
    private let accessTokenKey = "ACCESS_TOKEN_KEY"
    private let refreshTokenKey = "REFRESH_TOKEN_KEY"
    private let userKey = "USER_KEY"
    
    func save(user: User) -> Result<Void, ErrorCause> {
        return Result {
            let data = try encoder.encode(user)
            userDefaults.set(data, forKey: userKey)
        }
        .mapError { error in ErrorCause(error) }
    }
    
    func save(accessToken: String) {
        userDefaults.set(accessToken, forKey: accessTokenKey)
    }
    
    func getAccessToken() -> String? {
        userDefaults.string(forKey: accessTokenKey)
    }
    
    func save(refreshToken: String) {
        userDefaults.set(refreshToken, forKey: refreshTokenKey)
    }
    
    func getRefreshToken() -> String? {
        userDefaults.string(forKey: refreshTokenKey)
    }
}
