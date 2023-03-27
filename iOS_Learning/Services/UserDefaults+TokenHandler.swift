//
//  UserDefaults+TokenHandler.swift
//  iOS_Learning
//
//  Created by Vlad_Rosca on 27.03.2023.
//

import Foundation

extension UserDefaults {
    
    struct TokenHandler {
                
        private static let accessTokenKey = "ACCESS_TOKEN_KEY"
        private static let refreshTokenKey = "REFRESH_TOKEN_KEY"
        
        static func setAccessToken(accessToken: String) {
            UserDefaults.standard.set(accessToken, forKey: accessTokenKey)
        }
        
        static func setRefreshToken(refreshToken: String) {
            UserDefaults.standard.set(refreshToken, forKey: refreshTokenKey)
        }
        
        static func getAccessToken() -> String? {
            UserDefaults.standard.string(forKey: accessTokenKey)
        }
        
        static func getRefreshToken() -> String? {
            UserDefaults.standard.string(forKey: refreshTokenKey)
        }
    }
}
