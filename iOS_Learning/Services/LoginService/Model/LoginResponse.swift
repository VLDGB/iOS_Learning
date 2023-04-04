//
//  LoginResponse.swift
//  iOS_Learning
//
//  Created by Vlad_Rosca on 23.03.2023.
//

struct LoginResponse: Decodable {
    let accessToken: String
    let refreshToken: String
    
    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}

// Example of alternative enum for a decodable API response
//
//enum LoginResponse: Decodable {
//    case accessToken(String)
//    case refreshToken(String)
//
//    private enum CodingKeys: String, CodingKey {
//        case accessToken = "access_token"
//        case refreshToken = "refresh_token"
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        let decodedAccessToken = try container.decodeIfPresent(String.self, forKey: .accessToken)
//        let decodedRefreshToken = try container.decodeIfPresent(String.self, forKey: .refreshToken)
//
//        switch (decodedAccessToken, decodedRefreshToken) {
//        case let (accessToken?, _):
//            self = .accessToken(accessToken)
//        case let (_, refreshToken?):
//            self = .refreshToken(refreshToken)
//        default:
//            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Unable to decode"))
//        }
//    }
//}
