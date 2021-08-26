//
//  SignUpVM.swift
//  AppStructure
//
//  Created by Admin on 24/08/21.
//

import Foundation


struct SignUpVM {
    
    func signUpUser(signUpRequest: SignUpRequest) -> (result: Bool,error: String?) {
        let validationResult = SignUpValidation().validate(signUpRequest: signUpRequest)
        if(validationResult.success == false) {
            return (false,validationResult.error)
        }
       return (true,"")
    }
    
    func validateEmail(_ email: String) -> Bool {
        return SignUpValidation().validateEmail(email)
    }
    
    func validatePassword(_ password: String) -> Bool {
        return SignUpValidation().validatePassword(password)
    }
    
    func validateConfirmPassword(_ password: String, _ confirmPassword: String) -> Bool {
        return SignUpValidation().validateConfirmPassword(password,confirmPassword)
    }
   
}
