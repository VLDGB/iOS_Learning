//
//  ServerError.swift
//  iOS_Learning
//
//  Created by Vlad_Rosca on 26.03.2023.
//

import Foundation

enum ErrorCause: Error {
    case wrongCredentiales
    case unknown
    
    init(_ error: Error) {
        self = .unknown
    }
    
    init(_ code: Int) {
        switch code {
        case 401:
            self = .wrongCredentiales
        default:
            self = .unknown
        }
    }
}
