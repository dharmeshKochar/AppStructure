//
//  LoginPageValidation.swift
//  AppStructure
//
//  Created by Admin on 26/08/21.
//

import Foundation

struct LoginPageValidation {
    
    func validateEmail(_ email: String) -> Bool{
        if email.isValidEmail == false {
            return false
        }
        return true
    }
    
    func validatePassword(_ password: String) -> Bool{
        if password.count < 8 {
            return false
        }
        return true
    }
    
    func validate(loginRequest: LoginRequest) -> ValidationResult {
        if validateEmail(loginRequest.email!) == false {
            return ValidationResult(success: false, error: "email is not valid should be of proper domain")
        }
        if validatePassword(loginRequest.password!) == false {
            return ValidationResult(success: false, error: "Password should be of atlest 8 character")
        }
        return ValidationResult(success: true, error: nil)
    }
}
