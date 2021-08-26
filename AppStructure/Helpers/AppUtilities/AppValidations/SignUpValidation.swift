//
//  SignUpValidation.swift
//  AppStructure
//
//  Created by Admin on 26/08/21.
//

import Foundation

struct SignUpValidation{
    
    func validateEmail(_ email :String) -> Bool {
        if email.isValidEmail == false{
            return false
        }
        return true
    }
    
    func validatePassword(_ password :String) -> Bool {
        if password.count < 8{
            return false
        }
        return true
    }
    
    func validateConfirmPassword(_ password: String, _ confirmPassword: String) -> Bool {
        if confirmPassword == password && !confirmPassword.isEmpty {
            return true
        } else {
            return false
        }
    }

    func validate(signUpRequest: SignUpRequest) -> ValidationResult {
        if validateEmail(signUpRequest.email!) == false {
            return ValidationResult(success: false, error: StringConstant.InvalidEmail.value)
        }
        
        if validatePassword(signUpRequest.password!) == false {
            return ValidationResult(success: false, error: "Password should be minimum 8 characters")
        }
        
        if validateConfirmPassword(signUpRequest.confirmPassword!,signUpRequest.password!) == false {
            return ValidationResult(success: false, error: "Confirm password not matched to pasword")
        }
    return ValidationResult(success: true, error: nil)
    }
    
}
