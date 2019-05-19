//
//  File.swift
//  G-Mart
//
//  Created by Indrajit Chavda on 18/05/19.
//  Copyright © 2019 Indrajit Chavda. All rights reserved.
//

import Foundation


class AppErrors{
    static let invalidEmail = NSError(domain: "invalid_email".localize, code: 100, userInfo: [:] )
    static let invalidPasswordlenght = NSError(domain: "passowrd_must_be_more_than_three_chars".localize, code: 101, userInfo: [:] )
    
}
