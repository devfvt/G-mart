//
//  Validations.swift
//  G-Mart
//
//  Created by Indrajit Chavda on 18/05/19.
//  Copyright © 2019 Indrajit Chavda. All rights reserved.
//

import UIKit



extension String{
    func isEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}
