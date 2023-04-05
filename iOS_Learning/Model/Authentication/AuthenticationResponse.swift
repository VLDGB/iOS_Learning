//
//  AuthenticationResponse.swift
//  iOS_Learning
//
//  Created by Vlad_Rosca on 23.03.2023.
//

import Foundation


enum AuthenticationResponse {
    
    case success
    case failure(Error)
    
    enum Error {
        
        case wrongCreedentiales
        case failedToSaveUser
        case unknown
    }
    
    init(_ errorCause: ErrorCause) {
        switch errorCause {
        case .wrongCredentiales:
            self = .failure(Error.wrongCreedentiales)
        default:
            self = .failure(Error.unknown)
        }
    }
}
