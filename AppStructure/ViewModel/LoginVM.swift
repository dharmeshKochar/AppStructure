//
//  LoginVM.swift
//  AppStructure
//
//  Created by Admin on 24/08/21.
//

import Foundation

struct LoginVM {
 
    func loginUser(loginRequest: LoginRequest) -> (result: Bool,error: String?) {
      let validationResult = LoginPageValidation().validate(loginRequest: loginRequest)
        if(validationResult.success == false) {
            return (false,validationResult.error)
        }
            return (true,"")
    }
  
    func validateEmail(_ email: String) -> Bool{
        return LoginPageValidation().validateEmail(email)
    }
    
    func validatePassword(_ password: String) -> Bool{
        return LoginPageValidation().validatePassword(password)
    }
}
