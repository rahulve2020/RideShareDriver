//
//  ViewUtils.swift
//  ServiceHubConnect
//
//  Created by Imran on 30/01/22.
//

import UIKit

fileprivate let KIndicatorViewTag = 101010
class ViewUtils: NSObject {
    static func noDataAvailable(view: UIView, strMsg : String? = "No Data Available") {
        let noDataLbl = UILabel(frame: CGRect(x: view.frame.size.width/2 - 100, y: view.frame.size.height/2 - 20, width: 200, height: 40))
        noDataLbl.text = strMsg
        noDataLbl.textAlignment = .center
        noDataLbl.font = UIFont(name: KFont.medium, size: 18)
        view.addSubview(noDataLbl)
    }
    
    
    class func alertMessase(withTitle : String? = KString.strAppHeader, message : String?, cancelAction : (()->())? = nil , okAction : @escaping (()->()), controller : UIViewController) {
        
        let alertMessageController = UIAlertController(title: withTitle, message: message, preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: KString.cancel, style: .cancel) { (cancel) in
            cancelAction?()
        }
        let okButton = UIAlertAction(title: KString.ok, style: .default) { (ok) in
            okAction()
        }
        if cancelAction != nil {
            alertMessageController.addAction(cancelButton)
        }
        alertMessageController.addAction(okButton)
        controller.present(alertMessageController, animated: true, completion: nil)
    }
    
    
}


extension UIView {
    func shadow(color: UIColor, opacity : Float, sizeX : CGFloat, sizeY : CGFloat,shadowRadius : CGFloat){
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = CGSize(width: sizeX, height: sizeY)
        layer.shadowRadius = shadowRadius
        
    }
    
    func border(color : UIColor, width : CGFloat,radius : CGFloat) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
        layer.cornerRadius = radius
    }
    
    private func gradientWith(colors : [CGColor]) {
        if let _ = self.layer.sublayers {
            for  subLayer in self.layer.sublayers!{
                if subLayer.name == KString.layerName {
                    subLayer.removeFromSuperlayer()
                }
            }
        }
        let layerSub = CAGradientLayer()
        layerSub.name = KString.layerName
        layerSub.frame = self.bounds
        layerSub.startPoint = CGPoint(x: 0, y: 0.5)
        layerSub.endPoint = CGPoint(x: 1, y: 0.5)
        layerSub.colors = colors
        self.layer.insertSublayer(layerSub, at: 0)
    }
    
    func layerWithRect(rect : CGRect? = nil){
        
        if let _ = self.layer.sublayers {
            for  subLayer in self.layer.sublayers!{
                if subLayer.name == KString.layerName {
                    subLayer.removeFromSuperlayer()
                }
            }
        }
        
        let layerSub = CAGradientLayer()
        layerSub.name = KString.layerName
        layerSub.frame = (rect == nil) ? CGRect(x: 0, y: self.bounds.height-0.5, width: self.bounds.width, height: 0.5) : rect!
        layerSub.startPoint = CGPoint(x: 0, y: 0.5)
        layerSub.endPoint = CGPoint(x: 1, y: 0.5)
        layerSub.colors = [UIColor.gray.cgColor,UIColor.gray.cgColor]
        self.layer.insertSublayer(layerSub, at: 0)
    }
    
    func gradientRedColor() {
        //self.gradientWith(colors: [UIColor.hexStrAppTheme.cgColor,UIColor.hexStrAppTheme.cgColor])
    }
    
    func addTopBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: borderWidth)
        addSubview(border)
    }

    func addBottomBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        border.frame = CGRect(x: 0, y: frame.size.height - borderWidth, width: frame.size.width, height: borderWidth)
        addSubview(border)
    }

    func addLeftBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.frame = CGRect(x: 0, y: 0, width: borderWidth, height: frame.size.height)
        border.autoresizingMask = [.flexibleHeight, .flexibleRightMargin]
        addSubview(border)
    }

    func addRightBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin]
        border.frame = CGRect(x: frame.size.width - borderWidth, y: 0, width: borderWidth, height: frame.size.height)
        addSubview(border)
    }

}


//MARK: Add/Remove load indicator method
func addLoadIndicator(){
    removeLoadIndicator()
    let loadView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width,  height: UIScreen.main.bounds.size.height))
    loadView.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.1)
    loadView.tag = KIndicatorViewTag
    let activityIndicator = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.whiteLarge)
    activityIndicator.tag = KIndicatorViewTag+1
    activityIndicator.color = UIColor.black
    activityIndicator.center = loadView.center
    loadView.addSubview(activityIndicator)
    activityIndicator.startAnimating()
    UIApplication.shared.delegate?.window??.addSubview(loadView)
}

func removeLoadIndicator(){
    let appWindow = UIApplication.shared.delegate?.window
    appWindow??.viewWithTag(KIndicatorViewTag)?.viewWithTag(KIndicatorViewTag+1)?.removeFromSuperview()
    appWindow??.viewWithTag(KIndicatorViewTag)?.removeFromSuperview()
}

func alertMessase(strOk: String? = KString.ok,withTitle : String? = KString.strAppHeader, message : String?, cancelAction : (()->())? = nil , okAction : @escaping (()->())) {
    
    let alertMessageController = UIAlertController(title: withTitle, message: message, preferredStyle: .alert)
    let cancelButton = UIAlertAction(title:KString.cancel, style: .cancel) { (cancel) in
        cancelAction?()
    }
    let okButton = UIAlertAction(title: strOk, style: .default) { (ok) in
        okAction()
    }
    if cancelAction != nil {
        alertMessageController.addAction(cancelButton)
    }
    alertMessageController.addAction(okButton)
    let appWindow = UIApplication.shared.delegate?.window??.rootViewController
    appWindow?.present(alertMessageController, animated: true, completion: nil)
}

func storyboardOwner() -> UIStoryboard {
    return UIStoryboard(name: "Owner", bundle: Bundle.main)
}

func storyboardMain() -> UIStoryboard {
    return UIStoryboard(name: "Main", bundle: Bundle.main)
}

//func moveToUserDashboard() {
//    Facade.shared.isLoggedIn = true
//    //UserSingleton.shared.isLoggedIn = true
//    let objSHNavController = storyboardMain().instantiateViewController(withIdentifier: "SHNavController") as! SHNavController
//    KAppDelegate.window?.rootViewController = objSHNavController
//}

//func moveToOwnerDashboard() {
//    Facade.shared.isLoggedIn = true
//    //UserSingleton.shared.isLoggedIn = true
//    let objSHNavController = storyboardOwner().instantiateViewController(withIdentifier: "SHNavController") as! SHNavController
//    KAppDelegate.window?.rootViewController = objSHNavController
//}


//func setStoryboardView(){
//    //if let value = Facade.shared.isLogin{
//    if let value = Facade.shared.isLoggedIn{
//        if value{
//            if Facade.shared.isUser{
//                moveToUserDashboard()
//            }else{
//                moveToOwnerDashboard()
//            }
//
//    }
//}
//}

func setStatusBarColor(color:UIColor){
    if #available(iOS 13.0, *) {
        let statusBar = UIView(frame: (UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame)!)
        statusBar.backgroundColor = color
        UIApplication.shared.keyWindow?.addSubview(statusBar)
    } else {
        let statusBar1: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        statusBar1.backgroundColor = color
    }
}
