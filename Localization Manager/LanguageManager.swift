//

 import UIKit

extension String {
    var localize:String{
        
        return self.localized()
        
    }
    func localized() ->String {
     
        var currentSelectedLanguage = "en"
        if let val = UserDefaults.standard.object(forKey: "currentSelectedLanguage") as? String{
            currentSelectedLanguage = val
        }
        let path = Bundle.main.path(forResource: currentSelectedLanguage, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
   
    }
    
    
   static func timeFormateContryWise()->String{
       
        var currentSelectedLanguage = "en"
        if let val = UserDefaults.standard.object(forKey: "currentSelectedLanguage") as? String{
            currentSelectedLanguage = val
        }
       
        switch currentSelectedLanguage {
        case "de":
            return "de"
        case "es":
            return "es_ES"
        case "pt-PT":
            return "pt_PT"
        default:
            return "en_US_POSIX"
        }
  
    }
    
    static func getAMPMSymbol()->(am:String,pm:String){
        
        var currentSelectedLanguage = "en"
        if let val = UserDefaults.standard.object(forKey: "currentSelectedLanguage") as? String{
            currentSelectedLanguage = val
        }
        
        switch currentSelectedLanguage {
            /*
              Not show time localize show change 
             */
            
        case "de":
            return ("am","pm")
        case "es":
            return ("am","pm")
        case "pt-PT":
            return ("AM","PM")
        default:
            return ("am","pm")
        }
        
    }
   
    
    
}


@objc class LocalizeString:NSObject{
    
    @objc static func locallize(key:String)->String{
        return key.localized()
    }
}

protocol XIBLocalizable {
    var langKey: String? { get set }
}

extension UILabel: XIBLocalizable {
    
    @IBInspectable var langKey: String? {
        get {
            return nil
        }
        set(key) {
            text = key?.localized()
        }
    }
}

extension UIButton: XIBLocalizable {
    @IBInspectable var langKey: String? {
        get { return nil }
        set(key) {
            setTitle(key?.localized(), for: .normal)
        }
    }
}

extension UITextField: XIBLocalizable {
    
    @IBInspectable var langKey: String? {
        get { return nil }
        set(key) {
            placeholder = key?.localized()
        }
    }
    
}

extension UISearchBar: XIBLocalizable {
    
    @IBInspectable var langKey: String? {
        get { return nil }
        set(key) {
            placeholder = key?.localized()
            setValue("cancel".localized(), forKey:"_cancelButtonText")
        }
    }
    
}

extension UITabBarItem:XIBLocalizable{
    @IBInspectable var langKey: String? {
        get { return nil }
        set(key) {
            title = key?.localized()
        }
    }
    
}


extension UISegmentedControl{
   
    
    @IBInspectable var index0_key: String? {
        get { return nil }
        set(key) {
            self.setTitle(key?.localized(), forSegmentAt: 0)
        }
    }
    
    @IBInspectable var index1_key: String? {
        get { return nil }
        set(key) {
            self.setTitle(key?.localized(), forSegmentAt: 1)
        }
    }
    
}









