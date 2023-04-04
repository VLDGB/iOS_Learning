//
//  URLSessionRestClient.swift
//  iOS_Learning
//
//  Created by Vlad_Rosca on 31.03.2023.
//

import Foundation.NSURLSession

struct URLSessionRestClient: RestClientProtocol {
    
    private let urlSession = URLSession.shared
    
    func send(urlRequest: URLRequest, completion: @escaping (Result<Data?, ErrorCause>) -> Void) {
        
        urlSession.dataTask(with: urlRequest) { data, response, error in
            
            log(
                message: "URL: \(String(describing: urlRequest.url))",
                fileName: #file,
                functionName: #function,
                payload: data
            )
            
            if let error = error {
                log(
                    message: "URL: \(String(describing: urlRequest.url)) - ERROR: \(String(describing: error))",
                    fileName: #file,
                    functionName: #function
                )
                
                let errorCause = ErrorCause(error)
                completion(.failure(errorCause))
                
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                log(
                    message: "URL: \(String(describing: urlRequest.url)) - ERROR: NO STATUS CODE",
                    fileName: #file,
                    functionName: #function
                )
                completion(.failure(.notFound))
                
                return
            }
            
            if statusCode > 300 {
                let errorCause = ErrorCause(statusCode)
                log(
                    message: "URL: \(String(describing: urlRequest.url)) - STATUS CODE : \(statusCode)",
                    fileName: #file,
                    functionName: #function
                )
                completion(.failure(errorCause))

                return
            }
            
            completion(.success(data))
        }
        .resume()
    }
}
