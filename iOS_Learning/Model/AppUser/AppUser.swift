//
//  AppUser.swift
//  iOS_Learning
//
//  Created by Vlad_Rosca on 02.04.2023.
//
import Foundation.NSURL

enum AppUser {
    case email(String)
    case name(String)
    case avatarImageURL(URL?)
    case role(String)
    case id(Int)
    case createdAt(Date)
    
    init(_ user: User) {
        switch user {
        case .email(let value):
            self = .email(value)
        case .name(let value):
            self = .name(value)
        case .avatarImageURL(let value):
            self = .avatarImageURL(value)
        case .role(let value):
            self = .role(value)
        case .id(let value):
            self = .id(value)
        case .createdAt(let value):
            self = .createdAt(value)
        }
    }
}
