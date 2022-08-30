//
//  Facade.swift
//  Freeluancer
//
//  Created by Imran malik on 19/02/20.
//  Copyright © 2020 virtualEmployee. All rights reserved.
//

import Foundation
//import MaterialComponents
import UIKit

@available(iOS 13.0, *)
class Facade: NSObject {
    //MARK: Variables
    static let shared : Facade = Facade()
    private override init() {
        super.init()
    }

    func showAlert(vc:UIViewController){
        let alert = UIAlertController(title: "Login?", message: "You are not Login. Please Login First", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Login",
                  style: UIAlertAction.Style.destructive,
                  handler: {(_: UIAlertAction!) in
                     let story = UIStoryboard(name: "Main", bundle:nil)
                                       let vc = story.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                                 let navigationController = UINavigationController(rootViewController: vc)
                    navigationController.navigationBar.isHidden = true
                                       UIApplication.shared.windows.first?.rootViewController = navigationController
                                       UIApplication.shared.windows.first?.makeKeyAndVisible()
                                        //Sign out action
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
            
            vc.dismiss(animated: true, completion: nil)

        }))
        vc.present(alert, animated: true, completion: nil)
    }
    
    func dateConvert1(strDate: String) -> String {
        var stringDate : String?
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM d, yyyy"

        if let date = dateFormatterGet.date(from: strDate) {
            if Calendar.current.isDateInToday(date){
                let dateFormatterPrint = DateFormatter()
                dateFormatterPrint.dateFormat = "hh:mm a"
                let time = dateFormatterPrint.string(from: date)
                stringDate = "\(time) | Today"
            }else if Calendar.current.isDateInYesterday(date){
                let dateFormatterPrint = DateFormatter()
                dateFormatterPrint.dateFormat = ""
                let time = dateFormatterPrint.string(from: date)
                stringDate = "\(time)  Yesterday"
            }else{
                stringDate = dateFormatterPrint.string(from: date)
            }
        }
        return stringDate ?? ""
    }
   var isLogin : Bool{
        
        get{
            
            if let result = UserDefaults.standard.value(forKey: Apphelper.Constants.UserDefaults.loginStatus) as? Bool
            {
                return result
            }
            else
            {
                return false
            }
        }
        
        set(newValue){
            
            UserDefaults.standard.setValue(newValue, forKey: Apphelper.Constants.UserDefaults.loginStatus)
        }
    }
    
    
    var isLoginSeeker : Bool{
           get{
               if let result = UserDefaults.standard.value(forKey: Apphelper.Constants.UserDefaults.loginStatusSeeker) as? Bool
               {
                   return result
               }
               else
               {
                   return false
               }
           }
           set(newValue){
               UserDefaults.standard.setValue(newValue, forKey: Apphelper.Constants.UserDefaults.loginStatusSeeker)
           }
       }
    
    var isEnableNotifification : Bool{
        
        get{
            
            if let result = UserDefaults.standard.value(forKey: Apphelper.Constants.UserDefaults.isEnableNotifification) as? Bool
            {
                return result
            }
            else
            {
                return false
            }
        }
        
        set(newValue){
            
            UserDefaults.standard.setValue(newValue, forKey: Apphelper.Constants.UserDefaults.isEnableNotifification)
        }
    }
    
    var voipDeviceToken : String?{
        
        get{
            
            if let token = UserDefaults.standard.value(forKey: "") as? String
            {
                return token
            }
            
            return nil
        }
        
        set(newValue){
            
            UserDefaults.standard.setValue( newValue!, forKey: "")
        }
    }
    
    var isEnableSoundNotifification : Bool{
        
        get{
            
            if let result = UserDefaults.standard.value(forKey: Apphelper.Constants.UserDefaults.isEnableSoundNotifification) as? Bool
            {
                return result
            }
            else
            {
                return false
            }
        }
        
        set(newValue){
            
            UserDefaults.standard.setValue(newValue, forKey: Apphelper.Constants.UserDefaults.isEnableSoundNotifification)
        }
    }
    
    
    
    var formatCommon : String{
        
        get{
            
            return "dd-MM-yyyy"
        }
    }
    
    var formatServer : String{
        
        get{
            
            return "yyyy-MM-dd"
        }
    }
    
    var formatCommonTime : String{
        
        get{
            return "hh:mm a"
        }
    }
    
    var formatServerTime : String{
        
        get{
            return "HH:mm:ss"
        }
    }
    
    //var typeCategory : CategoryType?
    var typeSubcategory : Int = 0
    var businessId : Int = 0
    //var serviceType : VendorService?
    //var currency : String = UserSingleton.shared.Currency!
    var authToken : String?{
        
        get{
            
            if let token = UserDefaults.standard.value(forKey: Apphelper.Constants.UserDefaults.authToken) as? String
            {
                return token
            }
            
            return nil
        }
        
        set(newValue){
            
            UserDefaults.standard.setValue("Bearer " + newValue!  , forKey: Apphelper.Constants.UserDefaults.authToken)
        }
    }
    
//    var userDetail : SignUpViewModel?{
//        
//        get{
//            
//            if let info = UserDefaults.standard.value(forKey: Apphelper.Constants.UserDefaults.userInfo) as? Dictionary<String,Any>
//            {
//                return self.getUserInfoViewModel(json: info)
//            }
//            else
//            {
//                return nil
//            }
//        }
//        
//        set(newValue){
//            
//            UserDefaults.standard.setValue( newValue == nil ? nil : self.getUserInfoJson(viewModel: newValue!), forKey: Apphelper.Constants.UserDefaults.userInfo)
//        }
//    }
    
    
    /**
     * Email Verification
     */
    func isValidEmail(testStr:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    /**
     * Mobile Number Verification
     */
    func isValidMobileNumber(value: String) -> Bool {
        let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
    /**
     * Password Verification
     */
    func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{6,}$")
        return passwordTest.evaluate(with: password)
    }
    
    /**
     * Show normal alert
     */
//    func showAlert(msg : String, controller : UIViewController)
//    {
//        let alert : MDCAlertController = MDCAlertController.init(title: nil, message: msg)
//
//        let ok : MDCAlertAction = MDCAlertAction.init(title: Apphelper.Constants.StringConstant.ok, handler: nil)
//
//        alert.addAction(ok)
//
//        controller.present(alert, animated: true, completion: nil)
//    }
    
    func showAlertWithHandler(message :String, title : String?, firstBtnText: String?, secondBtnText: String?,controller : UIViewController,  firstBtnBlock:  @escaping () -> (), secondBtnBlock: @escaping () -> ())
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alertController.addAction(UIAlertAction(title: firstBtnText, style: UIAlertAction.Style.default, handler: {(action:UIAlertAction) in
            
            firstBtnBlock()
        }));
        
        if(secondBtnText != nil){
            
            alertController.addAction(UIAlertAction(title: secondBtnText, style: UIAlertAction.Style.default, handler: {(action:UIAlertAction) in
                
                // _ = self.navigationController?.popViewController(animated: true)
                secondBtnBlock()
            }));
        }
        
        DispatchQueue.main.async {
            controller.present(alertController, animated: true, completion: nil)
        }
    }
    
//    func showAlertWithTitle(title : String, msg : String, controller : UIViewController)
//    {
//        let alertController : MDCAlertController = MDCAlertController.init(title: title, message: msg)
//
//        let ok : MDCAlertAction = MDCAlertAction.init(title: Apphelper.Constants.StringConstant.ok, handler: nil)
//
//        alertController.addAction(ok)
//
//        controller.present(alertController, animated: true, completion: nil)
//    }
//    
//    func showAlertTitle(title : String, msg : String, controller : UIViewController)
//    {
//        let alertController : MDCAlertController = MDCAlertController.init(title: title, message: msg)
//
//        let ok : MDCAlertAction = MDCAlertAction.init(title: Apphelper.Constants.StringConstant.ok, handler: nil)
//
//        alertController.addAction(ok)
//        controller.dismiss(animated: true, completion: nil)
//
//    }
    
//    func showAlertWithTitleCell(title : String, msg : String )
//    {
//        let alertController : MDCAlertController = MDCAlertController.init(title: title, message: msg)
//        
//        let ok : MDCAlertAction = MDCAlertAction.init(title: Apphelper.Constants.StringConstant.ok, handler: nil)
//        
//        alertController.addAction(ok)
//        
//       // controller.present(alertController, animated: true, completion: nil)
//    }

//
//    func getUserInfoJson(viewModel : SignUpViewModel) -> Dictionary<String, Any>
//    {
//        var dicInfo : Dictionary<String, Any> = Dictionary()
//
//        dicInfo["name"] = viewModel.name
//        dicInfo["email"] = viewModel.email
//        dicInfo["password"] = viewModel.password
//        dicInfo["mobile"] = viewModel.mobile
//        return dicInfo
//    }
    
  //  func getUserInfoViewModel(json : Dictionary<String, Any>) -> SignUpViewModel
  //  {
     //   return SignUpViewModel.init(model: SignUpModel.init(json: json))
  //  }
    
    
    
    
    /// Returns date from string date
    ///
    /// - Parameters:
    ///   - strDate: date in string
    ///   - format: string date format
    ///   - timeZone: timezone to convert
    
    func trimContacts(strContact : String) -> String
    {
        return (strContact.components(separatedBy: CharacterSet.decimalDigits.inverted) as NSArray).componentsJoined(by: "")
    }
    
    func dateConversion(strDate: String) -> String {
        var stringDate : String?
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "hh:mm a | MMM d, yyyy"

        if let date = dateFormatterGet.date(from: strDate) {
            if Calendar.current.isDateInToday(date){
                let dateFormatterPrint = DateFormatter()
                dateFormatterPrint.dateFormat = "hh:mm a"
                let time = dateFormatterPrint.string(from: date)
                stringDate = "\(time) | Today"
            }else if Calendar.current.isDateInYesterday(date){
                let dateFormatterPrint = DateFormatter()
                dateFormatterPrint.dateFormat = "hh:mm a"
                let time = dateFormatterPrint.string(from: date)
                stringDate = "\(time) | Yesterday"
            }else{
                stringDate = dateFormatterPrint.string(from: date)
            }
        }
        return stringDate ?? ""
    }
    
    
    func dateConvert(strDate: String) -> String {
        var stringDate : String?
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM d, yyyy"

        if let date = dateFormatterGet.date(from: strDate) {
            if Calendar.current.isDateInToday(date){
                let dateFormatterPrint = DateFormatter()
                dateFormatterPrint.dateFormat = "hh:mm a"
                let time = dateFormatterPrint.string(from: date)
                stringDate = "\(time) | Today"
            }else if Calendar.current.isDateInYesterday(date){
                let dateFormatterPrint = DateFormatter()
                dateFormatterPrint.dateFormat = "hh:mm a"
                let time = dateFormatterPrint.string(from: date)
                stringDate = "\(time) | Yesterday"
            }else{
                stringDate = dateFormatterPrint.string(from: date)
            }
        }
        return stringDate ?? ""
    }
    
    
}

extension UIButton {
    func makeimageRound(){
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.height / 2
    }
}

extension UIImageView
{
    func makeRoundImage()
    {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.height / 2
    }
    
    func makecornerImage(){
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.clipsToBounds = true
        self.layer.cornerRadius = 10.0
    }
    
    func primaryBorderColor(){
        self.layer.borderColor = UIColor(red: 127/255, green: 41/255, blue: 87/255, alpha: 1).cgColor
        self.layer.borderWidth = 1.1
        self.layer.masksToBounds = true
        self.clipsToBounds = true
        self.layer.cornerRadius = 8.0
    }
   
    
    var isLoggedIn : Bool? {
        get {
            var isLogg: Bool?
            let defaults = UserDefaults.standard
            if (defaults.value(forKey: "isLoggedIn")) != nil{
                isLogg = defaults.value(forKey: "isLoggedIn") as? Bool
            }
            return isLogg
        }
        set{
            let defaults = UserDefaults.standard
            defaults.set(newValue, forKey: "isLoggedIn")
            defaults.synchronize()
        }
    }
//    func shadowSetFunc(){
//        self.layer.cornerRadius = 3
//        self.layer.shadowColor = UIColor.gray.cgColor
//        self.layer.shadowOffset = CGSize(width: 0, height: 1)
//        self.layer.shadowRadius = 1.7
//        self.layer.shadowOpacity = 0.45
//    }
    
    
}



extension UIView {
    func shadowSetFunc(){
        self.layer.cornerRadius = 2
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.40
    }
}

extension UIView {
    func getRecentPost(){
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.clipsToBounds = true
        self.layer.cornerRadius = 8.0
    }
}

//==============
// Protocol
//==============

protocol TableViewButton {
    func onClickButton()
}

protocol TableViewoptionButton1 {
    func clickOptionBtn(providerID: Int, postID: Int)
}

protocol TableViewoptionButton {
    func clickOptionBtn()
}

protocol TableViewlikeButton {
    func likeBtnClicked()
}


protocol MyCellDelegate: AnyObject {
    func btnCloseTapped(cell: Int )
}

protocol ShareButton {
    func onShareButton()
}


protocol WriteReviewButton {
    func onReviewButton()
}

protocol videoButton {
    func clickVideoBtn()
}
protocol PopUpButton {
    func PopUpAction()
}

protocol NewDownloadCellDelegate {
    func newBidApply(index:Int)
}

protocol SubmitProjectDownloadDelegate {
    func ProjectDownload(index:Int)
}

protocol AttachmentOpenDelegate {
    func ProjectOpen(index:Int)
}

protocol AttachmentOpenCollDelegate {
    func AttachmentOpen(index:Int)
}
