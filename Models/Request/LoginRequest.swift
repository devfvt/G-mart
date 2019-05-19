//
//  LoginModels.swift
//  G-Mart
//
//  Created by Indrajit Chavda on 28/04/19.
//  Copyright © 2019 Indrajit Chavda. All rights reserved.
//

import ObjectMapper





class LoginRequest:BaseRequest {
    
    var email:String?
    var password:String?
  
    override func mapping(map: Map) {
        super.mapping(map: map)
        email <- map["email"]
        password <- map["password"]
        
    }
}
