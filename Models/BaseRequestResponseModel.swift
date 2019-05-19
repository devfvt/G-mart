//
//  File.swift
//  G-Mart
//
//  Created by Indrajit Chavda on 18/05/19.
//  Copyright © 2019 Indrajit Chavda. All rights reserved.
//


import ObjectMapper
class BaseRequest:Mappable {
    required init?(map: Map) {
        
    }
    init() {
        
    }
    
    func mapping(map: Map) {
        
    }
}



class BaseResponse:Mappable {
    
    var status:Int?
    var data:[String:Any]?
    required init?(map: Map) {
    }
    
    init() {
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        data <- map["data"]
        
    }
    
    
}
