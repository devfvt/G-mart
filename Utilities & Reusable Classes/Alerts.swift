//
//  Alerts.swift
//  G-Mart
//
//  Created by Indrajit Chavda on 18/05/19.
//  Copyright © 2019 Indrajit Chavda. All rights reserved.
//

import UIKit


class ShowToast: NSObject {
    static var lastToastLabelReference:UILabel?
    static var initialYPos:CGFloat = 0
    class func show(toatMessage:String,feedBack:Bool = false)
    {
        
        LineProgress.hide()
        RoundProgress.hide()
        if toatMessage.replacingOccurrences(of: " ", with: "").count == 0{
            return
        }
        
        
        if let keyWindow = UIApplication.shared.keyWindow{
            
            if lastToastLabelReference != nil
            {
                let prevMessage = lastToastLabelReference!.text?.replacingOccurrences(of: " ", with: "").lowercased()
                let currentMessage = toatMessage.replacingOccurrences(of: " ", with: "").lowercased()
                if prevMessage == currentMessage
                {
                    return
                }
            }
            
            if feedBack{
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.error)
            }
            
            let cornerRadious:CGFloat = 12
            let toastContainerView:UIView={
                let view = UIView()
                view.layer.masksToBounds = true
                view.layer.cornerRadius = cornerRadious
                view.layer.borderColor = UIColor.white.cgColor
                view.layer.borderWidth = 0.4
                view.translatesAutoresizingMaskIntoConstraints = false
                view.backgroundColor = UIColor.init(red: 31/255, green: 46/255, blue: 69/255, alpha: 1)
                return view
            }()
            let labelForMessage:UILabel={
                let label = UILabel()
                label.layer.cornerRadius = cornerRadious
                label.layer.masksToBounds = true
                label.textAlignment = .center
                label.numberOfLines = 0
                label.adjustsFontSizeToFitWidth = true
                label.translatesAutoresizingMaskIntoConstraints = false
                label.text = toatMessage
                label.textColor = .white
                label.backgroundColor = UIColor.init(white: 0, alpha: 0)
                return label
            }()
            
            keyWindow.addSubview(toastContainerView)
            let fontType = UIFont.systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 14 : 13)
            labelForMessage.font = fontType
            
            let sizeOfMessage = NSString(string: toatMessage).boundingRect(with: CGSize(width: keyWindow.frame.width, height: keyWindow.frame.height), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font:fontType], context: nil)
            
            let topAnchor = toastContainerView.bottomAnchor.constraint(equalTo: keyWindow.topAnchor, constant: 0)
            keyWindow.addConstraint(topAnchor)
            
            toastContainerView.centerXAnchor.constraint(equalTo: keyWindow.centerXAnchor, constant: 0).isActive = true
            
            var extraHeight:CGFloat = 0
            if (keyWindow.frame.size.width) < (sizeOfMessage.width+20)
            {
                extraHeight = (sizeOfMessage.width+20) - (keyWindow.frame.size.width)
                toastContainerView.leftAnchor.constraint(equalTo: keyWindow.leftAnchor, constant: 5).isActive = true
                toastContainerView.rightAnchor.constraint(equalTo: keyWindow.rightAnchor, constant: -5).isActive = true
            }
            else
            {
                toastContainerView.widthAnchor.constraint(equalToConstant: sizeOfMessage.width+20).isActive = true
            }
            let totolHeight:CGFloat = sizeOfMessage.height+15+extraHeight
            toastContainerView.heightAnchor.constraint(equalToConstant:totolHeight).isActive = true
            toastContainerView.addSubview(labelForMessage)
            lastToastLabelReference = labelForMessage
            labelForMessage.topAnchor.constraint(equalTo: toastContainerView.topAnchor, constant: 0).isActive = true
            labelForMessage.bottomAnchor.constraint(equalTo: toastContainerView.bottomAnchor, constant: 0).isActive = true
            labelForMessage.leftAnchor.constraint(equalTo: toastContainerView.leftAnchor, constant: 5).isActive = true
            labelForMessage.rightAnchor.constraint(equalTo: toastContainerView.rightAnchor, constant: -5).isActive = true
            keyWindow.layoutIfNeeded()
            
            let padding:CGFloat = initialYPos == 0 ? 65 : 10 // starting position
            initialYPos += padding+totolHeight
            topAnchor.constant = initialYPos
            
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9, options: .curveEaseIn, animations: {
                keyWindow.layoutIfNeeded()
            }, completion: { (bool) in
                topAnchor.constant = 0
                UIView.animate(withDuration: 0.4, delay: 3, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveLinear, animations: {
                    keyWindow.layoutIfNeeded()
                }, completion: { (bool) in
                    if let lastToastShown = lastToastLabelReference,labelForMessage == lastToastShown
                    {
                        lastToastLabelReference = nil
                    }
                    initialYPos -= (padding+totolHeight)
                    toastContainerView.removeFromSuperview()
                })
            })
        }
    }
}

class AlertView{
    
    static func show(title:String? = nil,message:String?,preferredStyle: UIAlertController.Style = .alert,buttons:[String] = ["ok".localize],sourceRect:CGRect? = nil,completionHandler:@escaping (String)->Void){
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        for button in buttons{
            
            var style = UIAlertAction.Style.default
            let buttonText = button.lowercased().replacingOccurrences(of: " ", with: "")
            if (buttonText == "cancel".localize || buttonText == "cancel"),UIDevice.current.userInterfaceIdiom != .pad{
                style = .cancel
            }
            let action = UIAlertAction(title: button, style: style) { (_) in
                completionHandler(button)
            }
            alert.addAction(action)
        }
        
        DispatchQueue.main.async {
            if let rootViewController = UIViewController.getVisibleViewController(nil){
                LineProgress.hide()
                if UIDevice.current.userInterfaceIdiom == .pad,preferredStyle == .actionSheet {
                    if let rect = sourceRect{
                        alert.popoverPresentationController?.sourceRect = rect
                    }else{
                        alert.popoverPresentationController?.permittedArrowDirections = .init(rawValue: 0)
                        alert.popoverPresentationController?.sourceRect = CGRect(x: UIScreen.main.bounds.width/2 - 100, y: UIScreen.main.bounds.height/2 - 300, width: 200, height: 600)
                    }
                    
                    alert.popoverPresentationController?.sourceView = rootViewController.view
                    rootViewController.present(alert, animated: true, completion: nil)
                }  else {
                    rootViewController.present(alert, animated: true, completion: nil)
                }
            }
            
        }
    }
}
