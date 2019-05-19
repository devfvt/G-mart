//
//  ViewContrainsHelper.swift
//  G-Mart
//
//  Created by Indrajit Chavda on 18/05/19.
//  Copyright © 2019 Indrajit Chavda. All rights reserved.
//

import UIKit


extension UIView{
    
    
    func addSubviews(views:[UIView]){
        views.forEach { (_view) in
            addSubview(_view)
        }
    }
    
    func setAnchors(top:NSLayoutYAxisAnchor?,bottom:NSLayoutYAxisAnchor?,left:NSLayoutXAxisAnchor?,right:NSLayoutXAxisAnchor?,topConstant:CGFloat,bottomConstant:CGFloat,leftConstant:CGFloat,rightConstant:CGFloat){
        if let value = left{
            setLeft(with: value, constant: leftConstant)
        }
        if let value = right{
            setRight(with: value, constant: rightConstant)
        }
        if let value = top{
            setTop(with: value, constant: topConstant)
        }
        if let value = bottom{
            setBottom(with: value, constant: bottomConstant)
        }
    }
    
    
    
    func setAnchors(top:NSLayoutYAxisAnchor?,bottom:NSLayoutYAxisAnchor?,left:NSLayoutXAxisAnchor?,right:NSLayoutXAxisAnchor?){
        if let value = left{
            setLeft(with: value, constant: 0)
        }
        if let value = right{
            setRight(with: value, constant: 0)
        }
        if let value = top{
            setTop(with: value, constant: 0)
        }
        if let value = bottom{
            setBottom(with: value, constant: 0)
        }
    }
    
    
    
    func setHeight(height:CGFloat){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func setHeight(height:NSLayoutDimension){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalTo: height, multiplier: 1).isActive = true
    }
    
    func setWidth(width:CGFloat){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func setWidth(width:NSLayoutDimension){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalTo: width, multiplier: 1).isActive = true
    }
    
    func setHeightAndWidth(height:CGFloat,width:CGFloat){
        setHeight(height: height)
        setWidth(width: width)
    }
    
    
    func setRight(with:NSLayoutXAxisAnchor){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.rightAnchor.constraint(equalTo: with).isActive = true
    }
    func setRight(with:NSLayoutXAxisAnchor,constant:CGFloat){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.rightAnchor.constraint(equalTo: with, constant: constant).isActive = true
    }
    func setLeft(with:NSLayoutXAxisAnchor){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leftAnchor.constraint(equalTo: with).isActive = true
    }
    func setLeft(with:NSLayoutXAxisAnchor,constant:CGFloat){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leftAnchor.constraint(equalTo: with, constant: constant).isActive = true
    }
    
    
    func setTop(with:NSLayoutYAxisAnchor){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: with).isActive = true
    }
    func setTop(with:NSLayoutYAxisAnchor,constant:CGFloat){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: with, constant: constant).isActive = true
    }
    func setBottom(with:NSLayoutYAxisAnchor){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.bottomAnchor.constraint(equalTo: with).isActive = true
    }
    func setBottom(with:NSLayoutYAxisAnchor,constant:CGFloat){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.bottomAnchor.constraint(equalTo: with, constant: constant).isActive = true
    }
    
    
    func setFullOnSuperView(){
        if let superViewOfThis = superview{
            self.setTop(with: superViewOfThis.topAnchor)
            self.setBottom(with: superViewOfThis.bottomAnchor)
            self.setLeft(with: superViewOfThis.leftAnchor)
            self.setRight(with: superViewOfThis.rightAnchor)
        }
    }
    
    func setCenterY(){
        if let superViewOfThis = superview{
            self.translatesAutoresizingMaskIntoConstraints = false
            self.centerYAnchor.constraint(equalTo: superViewOfThis.centerYAnchor, constant: 0).isActive = true
        }
    }
    
    func setCenterY(constant:CGFloat){
        if let superViewOfThis = superview{
            self.translatesAutoresizingMaskIntoConstraints = false
            self.centerYAnchor.constraint(equalTo: superViewOfThis.centerYAnchor, constant: constant).isActive = true
        }
    }
    
    
    func setCenterX(){
        if let superViewOfThis = superview{
            self.translatesAutoresizingMaskIntoConstraints = false
            self.centerXAnchor.constraint(equalTo: superViewOfThis.centerXAnchor, constant: 0).isActive = true
        }
    }
    
    func setCenterX(constant:CGFloat){
        if let superViewOfThis = superview{
            self.translatesAutoresizingMaskIntoConstraints = false
            self.centerXAnchor.constraint(equalTo: superViewOfThis.centerXAnchor, constant: constant).isActive = true
        }
    }
    
    func setCenterXto(xAnachor:NSLayoutXAxisAnchor,constant:CGFloat = 0){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: xAnachor, constant: constant).isActive = true
    }
    
    func setCenterYto(yAnchor:NSLayoutYAxisAnchor,constant:CGFloat = 0){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerYAnchor.constraint(equalTo: yAnchor, constant: constant).isActive = true
    }
    
    func setCenter(){
        setCenterX()
        setCenterY()
    }
    
    func setCenter(xConstant:CGFloat,yConstant:CGFloat){
        setCenterX(constant: xConstant)
        setCenterY(constant: yConstant)
    }
    
    
}
