//
//  UNRestClient.swift
//  iOS_Learning
//
//  Created by Vlad_Rosca on 23.03.2023.
//

import Foundation
import Alamofire

class UNRestClient: RestClient {
    
    func send(urlRequest: URLRequest, completion: @escaping (Result<Data?, ErrorCause>) -> Void) {
        AF.request(urlRequest).validate(statusCode: 200..<500).responseData { response in
            
            guard let statusCode = response.response?.statusCode else {
                let error = ErrorCause.unknown
                completion(.failure(error))
                return
            }
            
            switch response.result {
            case .success(let data):
                Logger.log(message: "UNRestClient.send() - URL: \(String(describing: urlRequest.url)) - Raw API Response:", data: data)
                
                if(statusCode < 300) {
                    completion(.success(data))
                } else {
                    Logger.log(message: "UNRestClient.send() - URL: \(String(describing: urlRequest.url)) - Status Code: \(String(statusCode))")

                    let errorCause = ErrorCause(statusCode)
                    completion(.failure(errorCause))
                }
                
            case .failure(let error):
                Logger.log(message: "UNRestClient.send() - URL: \(String(describing: urlRequest.url)) - Error: \(String(describing: error))")

                let errorCause = ErrorCause(error)
                completion(.failure(errorCause))
            }
        }
    }
}
