//
//  LoginViewModel.swift
//  G-Mart
//
//  Created by Indrajit Chavda on 28/04/19.
//  Copyright © 2019 Indrajit Chavda. All rights reserved.
//

import Foundation


class LoginViewModel{
    let apiRequest = APIRequest()
    
    func validateEmailAndPassword(email:String,password:String) throws{
        if !email.isEmail(){
            throw AppErrors.invalidEmail
        }else if password.count < 3{
            throw AppErrors.invalidPasswordlenght
        }
    }
    
    
    func loginRequest(email:String,password:String) throws{
        try self.validateEmailAndPassword(email: email, password: password)
        
        let urlString = URLManager.baseUrl + URLManager.login
        
        let parameters = LoginRequest()
        parameters.email = email
        parameters.password = password
        
        apiRequest.requestWithMappble(urlString: urlString, mapable: LoginResponse.self, method: .POST, parameters: parameters) { (response, serverError, error) in
            print(response?.toJSON())
        }
        
    }
    
    
}
