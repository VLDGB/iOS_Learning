//
//  ErrorCause.swift
//  iOS_Learning
//
//  Created by Vlad_Rosca on 26.03.2023.
//

enum ErrorCause: Error {
    case accessDenied
    case notFound
    case badRequest
    case technical
    case unspecified
    case unknown(error: Error)
    
    init(_ error: Error) {
        self = .unknown(error: error)
    }
    
    init(_ code: Int) {
        switch code {
        case 400:
            self = .badRequest
        case 401:
            self = .accessDenied
        case 404:
            self = .notFound
        default:
            self = .unspecified
        }
    }
}
