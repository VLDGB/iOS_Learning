//
//  Utils.swift
//  iOS_Learning
//
//  Created by Vlad_Rosca on 22.03.2023.
//

import Foundation.NSPredicate
import UIKit.UITextField

class Utils {

    static func isPasswordValid( password : String) -> Bool{
        let passwordTest = NSPredicate( format:"SELF MATCHES %@", "^[a-zA-Z0-9]+$")
        return passwordTest.evaluate(with: password)
    }
    
    static func isTextFieldEmpty(_ textField: UITextField) -> Bool {
        if let text = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            return text.isEmpty
        } else {
            return false
        }
    }
}
