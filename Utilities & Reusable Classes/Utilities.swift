

import UIKit


extension UIColor{
    static func rgb(r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat = 1)->UIColor{
        return UIColor.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
}

extension String{
    
    func addAtributes(color:UIColor,underlined:Bool = false)->NSAttributedString{
        let atString = NSMutableAttributedString()
        
        if underlined{
            atString.append(NSAttributedString(string: self, attributes:
                [.underlineStyle: NSUnderlineStyle.single.rawValue,NSAttributedString.Key.foregroundColor:color]))
        }else{
            atString.append(NSAttributedString(string: self, attributes: [NSAttributedString.Key.foregroundColor:color]))
        }
        return atString
    }
    
    func addAtributes(font:UIFont)->NSAttributedString{
        let atString = NSMutableAttributedString()
        atString.append(NSAttributedString(string: self, attributes: [NSAttributedString.Key.font:font]))
        return atString
    }
    
    func addAtributes(color:UIColor,font:UIFont)->NSAttributedString{
        let atString = NSMutableAttributedString()
        atString.append(NSAttributedString(string: self, attributes: [NSAttributedString.Key.font:font,NSAttributedString.Key.foregroundColor:color]))
        return atString
    }
    func addAtributes(color:UIColor,font:UIFont,paragraph:NSParagraphStyle)->NSAttributedString{
        let atString = NSMutableAttributedString()
        atString.append(NSAttributedString(string: self, attributes: [NSAttributedString.Key.font:font,NSAttributedString.Key.foregroundColor:color,NSAttributedString.Key.paragraphStyle:paragraph]))
        return atString
    }
    
    
    func withoutSpaces()->String{
        return self.replacingOccurrences(of: " ", with: "")
    }
}



extension UILabel {
    func textDropShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 1, height: 2)
    }
}


extension UIViewController{
    
    func push(dv:UIViewController){
        self.navigationController?.pushViewController(dv, animated: true)
    }
    
}

extension NSObject {
    func copyObject<T:NSObject>() throws -> T? {
        let data = try NSKeyedArchiver.archivedData(withRootObject:self, requiringSecureCoding:false)
        return try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? T
    }
}




extension UIViewController{
    static func getVisibleViewController(_ rootViewController: UIViewController?) -> UIViewController? {
        
        var rootVC = rootViewController
        if rootVC == nil {
            rootVC = UIApplication.shared.keyWindow?.rootViewController
        }
        
        var presented = rootVC?.presentedViewController
        if rootVC?.presentedViewController == nil {
            if let isTab = rootVC?.isKind(of: UITabBarController.self), let isNav = rootVC?.isKind(of: UINavigationController.self) {
                if !isTab && !isNav {
                    return rootVC
                }
                presented = rootVC
            } else {
                return rootVC
            }
        }
        
        if let presented = presented {
            if presented.isKind(of: UINavigationController.self) {
                if let navigationController = presented as? UINavigationController {
                    return navigationController.viewControllers.last!
                }
            }
            
            if presented.isKind(of: UITabBarController.self) {
                if let tabBarController = presented as? UITabBarController {
                    if let navigationController = tabBarController.selectedViewController! as? UINavigationController {
                        return navigationController.viewControllers.last!
                    } else {
                        return tabBarController.selectedViewController!
                    }
                }
            }
            
            return getVisibleViewController(presented)
        }
        return nil
    }
}






extension UIApplication{
    static var hasTopNotch: Bool {
        if #available(iOS 11.0,  *) {
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
        }
        return false
    }
}

extension UIImage {
    var isPortrait:  Bool    { return size.height > size.width }
    var isLandscape: Bool    { return size.width > size.height }
    var breadth:     CGFloat { return min(size.width, size.height) }
    var breadthSize: CGSize  { return CGSize(width: breadth, height: breadth) }
    var breadthRect: CGRect  { return CGRect(origin: .zero, size: breadthSize) }
    var circleMasked: UIImage? {
        UIGraphicsBeginImageContextWithOptions(breadthSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        guard let cgImage = cgImage?.cropping(to: CGRect(origin: CGPoint(x: isLandscape ? floor((size.width - size.height) / 2) : 0, y: isPortrait  ? floor((size.height - size.width) / 2) : 0), size: breadthSize)) else { return nil }
        UIBezierPath(ovalIn: breadthRect).addClip()
        UIImage(cgImage: cgImage, scale: 1, orientation: imageOrientation).draw(in: breadthRect)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
