//
//  StringConstants.swift
//  AppStructure
//
//  Created by Admin on 23/08/21.
//

import Foundation

enum StringConstant: String {
    case Email = "Email"
    case Password = "Password"
    case ConfirmPassword = "Confirm Password"
    
    case ValidEmail = "Valid Email"
    case InvalidEmail = "Invalid Email"
    case ValidPassword = "Valid Password"
    case InvalidPassword = "Invalid Password"
    case ValidConfirmPassword = "Matched"
    case InvalidConfirmPassword = "Not matched"
}


extension StringConstant {
    var value: String {
        return self.rawValue.localized
    }
}
