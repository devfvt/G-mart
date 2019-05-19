//
//  LoginResponse.swift
//  G-Mart
//
//  Created by Indrajit Chavda on 18/05/19.
//  Copyright © 2019 Indrajit Chavda. All rights reserved.
//

import Foundation
import ObjectMapper

class LoginResponse: BaseResponse {

    var userId:String?
    var name:String?
    var email:String?
    var mobile:String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        userId <- map["data.userId"]
        name <- map["data.name"]
        email <- map["data.email"]
        mobile <- map["data.mobile"]
    }
}
