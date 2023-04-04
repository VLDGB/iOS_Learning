//
//  AlamofireRestClient.swift
//  iOS_Learning
//
//  Created by Vlad_Rosca on 23.03.2023.
//

import Foundation.NSData
import Alamofire

struct AlamofireRestClient: RestClientProtocol {
    
    func send(urlRequest: URLRequest, completion: @escaping (Result<Data?, ErrorCause>) -> Void) {
        AF.request(urlRequest).validate(statusCode: 200..<500).responseData { response in
            
            guard let statusCode = response.response?.statusCode else {
                completion(.failure(.unspecified))
                return
            }
            
            switch response.result {
            case .success(let data):
                log(
                    message: "SUCCESS - URL: \(String(describing: urlRequest.url)) - Status Code: \(String(statusCode))",
                    fileName: #file,
                    functionName: #function,
                    payload: data
                )
                
                if(statusCode < 300) {
                    completion(.success(data))
                } else {
                    let errorCause = ErrorCause(statusCode)
                    completion(.failure(errorCause))
                }
                
            case .failure(let error):
                log(
                    message: "FAILURE - URL: \(String(describing: urlRequest.url)) - Status Code: \(String(statusCode)) - Error: \(String(describing: error))",
                    fileName: #file,
                    functionName: #function
                )
                
                let errorCause = ErrorCause(error)
                completion(.failure(errorCause))
            }
        }
    }
}
