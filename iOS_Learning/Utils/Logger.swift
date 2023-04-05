//
//  Logger.swift
//  iOS_Learning
//
//  Created by Vlad_Rosca on 27.03.2023.
//

import Foundation

struct Logger {
    
    static func log(message: String, data: Data? = nil) -> Void {
        if let wrappedData = data {
            print("\(message)  with payload:  \(String(data: wrappedData, encoding: .utf8) ?? "Error: Could not convert data to string")")
        } else {
            print(message)
        }
    }
}
