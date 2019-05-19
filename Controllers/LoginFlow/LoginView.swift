//
//  LoginView.swift
//  G-Mart
//
//  Created by Indrajit Chavda on 28/04/19.
//  Copyright © 2019 Indrajit Chavda. All rights reserved.
//

import UIKit


class LoginView:ParentViewController{
    
    //MARK: Class properties
    let loginViewModel = LoginViewModel()
    
    //MARK: Life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        
        login()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    
    //MARK: Other methods
  
    func setUpViews(){
        self.view.backgroundColor = .red
        title = "sign_in".localize
    }
    
    
    
    //MARK: Action methods
    
    func login(){
        
        
        try? loginViewModel.loginRequest(email: "shanil.soni19@gmail.com", password: "123456")
       
    }
    
}


