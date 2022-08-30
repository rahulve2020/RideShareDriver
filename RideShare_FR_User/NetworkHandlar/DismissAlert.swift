//
//  DismissAlert.swift
//  Workcocoon
//
//  Created by Sierra 3 on 05/07/17.
//  Copyright © 2017 CB Neophyte. All rights reserved.
//

import Foundation
import UIKit

enum SwiftAlertType: Int {
    case error
    case info
    case success
    case otp
}

enum DismissAlert : String{
    case success = "Success"
    case oops = "Oops"
    case login = "Login Successfull"
    case locationPermission = "Location Permissions"
    case ok = "Ok"
    case cancel = "Cancel"
    case error = "Error"
    case info = "Warning"
    case confirmation = "Confirmation"

    func showWithType(type : DismissAlert? = .info, message : String) {
        alertMessase(message: message) {}
    }
}

class Alert: NSObject {

    static func showAlertWithTitle(msg: String, controler: UIViewController){
        let alert = UIAlertController(title: "SAFE RIDE", message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .default, handler: nil)
        alert.addAction(action)
        controler.present(alert, animated: true, completion: nil)
    }
    
    static func showAlertWithTitle(msg: String, controler: UIViewController, completion: @escaping ()->Void){
        let alert = UIAlertController(title: "SAFE RIDE", message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .default) { (tapped) in
            completion()
        }
        alert.addAction(action)
        controler.present(alert, animated: true, completion: nil)
    }
    
    static func showAlertWithCancel(msg: String, controler: UIViewController, completion: @escaping ()->Void){
        let alert = UIAlertController(title: "SAFE RIDE", message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (tapped) in
            completion()
        }
        let actionCncel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(action)
        alert.addAction(actionCncel)
        controler.present(alert, animated: true, completion: nil)
        
    }
    class func showAlertWithTitle(_ title:String,Message msg: String,OkTitle okTitle: String, CancelTitle cancelTitle: String,Controller controller: UIViewController, callback:@escaping (_ title: String?) -> Void){
        
//
//        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
//
//        self.setAttributtedTextInAlert(alert, title: title, message: msg)
//
//        let okAction = UIAlertAction(title: okTitle, style: UIAlertAction.Style.default, handler:{ (ACTION :UIAlertAction)in
//            callback("OkTapped")
//        })
//        let cancelAction = UIAlertAction(title: cancelTitle, style: UIAlertAction.Style.cancel, handler:{ (ACTION :UIAlertAction)in
//
//            callback("CloseTapped")
//        })
//
//        alert.addAction(okAction)
//
//        alert.addAction(cancelAction)
//
//        okAction.setValue(UIColor.gray, forKey: "titleTextColor")
//        cancelAction.setValue(UIColor.gray, forKey: "titleTextColor")
//
//
//        //let vc = RootViewController.currentRootViewController()
//
//        controller.present(alert, animated: true, completion: nil)
        

         let alertMessageController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
         let cancelButton = UIAlertAction(title: "Cancel", style: .cancel) { (cancel) in
            callback("CloseTapped")
         }
         let okButton = UIAlertAction(title: "Ok", style: .default) { (ok) in
             callback("OkTapped")
         }
        
        
        
         alertMessageController.addAction(okButton)
        alertMessageController.addAction(cancelButton)
         controller.present(alertMessageController, animated: true, completion: nil)
         
        
    }
    
    class func showAlertWithAction(_ title:String? = "SAFE RIDE",Message msg: String,YesTitle yesTitle: String, CancelTitle cancelTitle: String,Controller controller: UIViewController, callbackYes:@escaping () -> Void,callbackNo:@escaping () -> Void){
        
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
         let cancelAction = UIAlertAction(title: cancelTitle, style: .default) { (cancel) in
            callbackNo()
         }
         let yesAction = UIAlertAction(title: yesTitle, style: .default) { (ok) in
             callbackYes()
         }
    
         alertController.addAction(yesAction)
         alertController.addAction(cancelAction)
         controller.present(alertController, animated: true, completion: nil)
    }
    
    class func alertMessase(strOk: String? = "OK",withTitle : String? = "SAFE RIDE", message : String?, cancelAction : (()->())? = nil , okAction : @escaping (()->())) {
        
        let alertMessageController = UIAlertController(title: withTitle, message: message, preferredStyle: .alert)
        let cancelButton = UIAlertAction(title:"Cancel", style: .cancel) { (cancel) in
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
    
    
    class func setAttributtedTextInAlert(_ alertControler: UIAlertController, title: String, message: String) -> Void {
        alertControler.setValue(NSAttributedString(string: title, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17),NSAttributedString.Key.foregroundColor : UIColor.black]), forKey: "attributedTitle")
        
        alertControler.setValue(NSAttributedString(string: message , attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15),NSAttributedString.Key.foregroundColor : UIColor.darkGray]), forKey: "attributedMessage")
    }

    
}
