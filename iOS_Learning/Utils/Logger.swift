//
//  Logger.swift
//  iOS_Learning
//
//  Created by Vlad_Rosca on 27.03.2023.
//

import Foundation.NSData


func log(
    message: String,
    fileName: String,
    functionName: String
) {
    print("\(fileName) - \(functionName) - \(message)")
}

func log(
    message: String,
    fileName: String,
    functionName: String,
    payload: Data?
) {
    if let payload = payload, let payloadString = String(data: payload, encoding: .utf8) {
        print("\(fileName) - \(functionName) - \(message)  - with payload: \(payloadString)))")
    } else {
        print("\(fileName) - \(functionName) - \(message) - unable to convert payload to string")
    }
}
