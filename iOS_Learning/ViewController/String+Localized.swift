//
//  String+Localized.swift
//  iOS_Learning
//
//  Created by Vlad_Rosca on 04.04.2023.
//

import func Foundation.NSLocalizedString

extension String {
    
    func localized(withComment comment: String = "") -> String { NSLocalizedString(self, comment: comment) }
}
