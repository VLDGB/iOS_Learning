//
//  Utilities.swift
//  iOS_Learning
//
//  Created by Vlad_Rosca on 22.03.2023.
//

import Foundation
import UIKit

class Utilities {

    static func isPasswordValid( password : String) -> Bool{
        let passwordTest = NSPredicate( format:"SELF MATCHES %@", "^[a-zA-Z0-9]+$")
        return passwordTest.evaluate (with: password)
    }
}
