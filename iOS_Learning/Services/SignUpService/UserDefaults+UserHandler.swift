//
//  UserDefaults+UserHandler.swift
//  iOS_Learning
//
//  Created by Vlad_Rosca on 27.03.2023.
//

import Foundation

extension UserDefaults {
    
    struct UserHandler{
                
        private static let userKey = "USER_KEY"
        
        static func saveUser(user: User) -> Bool {
            let userDefaults = UserDefaults.standard
            let encoder = JSONEncoder()
            
            do {
                let data = try encoder.encode(user)
                userDefaults.set(data, forKey: userKey)
                return true
            } catch {
                Logger.log(message: "Failed to save user: \(user) with Error: \(error)")
                return false
            }
        }
    }
}
