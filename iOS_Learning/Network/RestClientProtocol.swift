//
//  RestClientProtocol.swift
//  iOS_Learning
//
//  Created by Vlad_Rosca on 23.03.2023.
//

import Foundation.NSData

protocol RestClientProtocol {
    
    func send(urlRequest: URLRequest, completion: @escaping (Result<Data?, ErrorCause>) -> Void)
}
