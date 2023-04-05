//
//  Network.swift
//  iOS_Learning
//
//  Created by Vlad_Rosca on 23.03.2023.
//

import Foundation

protocol RestClient {
    func send(urlRequest: URLRequest, completion: @escaping (Result<Data?, ErrorCause>) -> Void)
}
