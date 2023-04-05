//
//  JSONDecoder+ISO8601DateDecodingStrategySetup.swift
//  iOS_Learning
//
//  Created by Vlad_Rosca on 02.04.2023.
//

import Foundation.NSJSONSerialization

extension JSONDecoder {
    
    func ISO8601DateDecodingStrategySetup() -> JSONDecoder {
        let dateFormatter = DateUtil.shared.dateFormatter
        self.dateDecodingStrategy = .formatted(dateFormatter)
        
        return self
    }
}
