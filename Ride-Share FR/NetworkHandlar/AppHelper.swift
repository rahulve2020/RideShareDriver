//
//  AppHelper.swift
//  Banquet Gem
//
//  Created by Imran malik on 01/02/22.
//  Copyright © 2020 virtualEmployee. All rights reserved.
//

import Foundation
import UIKit

@available(iOS 13.0, *)
@available(iOS 13.0, *)
class Apphelper: NSObject {
    
    static let appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
     struct Constants
    {
        
        struct API
        {

            
            static let BaseUrl = "http://3.85.159.240:3000/api/"
            
            static let signUp  = API.BaseUrl + "user/signup"
            static let otpVerify : String = API.BaseUrl + "user/verify"
            static let resendOtp : String = API.BaseUrl + "user/resend-otp"
            static let login : String = API.BaseUrl + "user/login"
            static let forgotPassword : String = API.BaseUrl + "user/forgot-password"
            static let resetPassword : String = API.BaseUrl + "user/reset-password"
            static let changePassword : String = API.BaseUrl + "driver/change-password"
            static let getProfile : String = API.BaseUrl + "driver/get-driver-profile"
            static let updateProfile : String = API.BaseUrl + "driver/update-profile"
            static let addDriverDocument : String = API.BaseUrl + "driver/add-documents"
            static let updateDriverDocument : String = API.BaseUrl + "driver/update-driver-document"
            
            static let vechicleDetails : String = API.BaseUrl + "driver/add-vehicle-details"
            static let vechicleUpdateDetails : String = API.BaseUrl + "driver/update-vehicle-details"
            static let getCategory : String = API.BaseUrl + "user/get-vehicle-category-list"
            static let ignorBooking : String = API.BaseUrl + "driver/ignore-booking-order"
            static let acceptBooking : String = API.BaseUrl + "driver/accept-booking-order"
            static let onlineDriverStatus : String = API.BaseUrl + "driver/update-online-status"
            static let getOrderListing : String = API.BaseUrl + "driver/get-booking-order-listing"
            static let getOrderByDate : String = API.BaseUrl + "driver/get-order-by-date"
            static let userOtpVerify : String = API.BaseUrl + "driver/verify-order-otp"
            static let orderStartRide : String = API.BaseUrl + "driver/update-order-start-time"
            static let booking_details : String = API.BaseUrl + "booking_details"
            static let getDocument   : String = API.BaseUrl + "driver/add-documents"
            static let getSubCategory : String = API.BaseUrl + "user/get-vegical-subcategory-list"
            static let getContactDetails : String = API.BaseUrl + "driver/submit-contact-us"
            static let getOrderComplete : String = API.BaseUrl + "driver/mark-order-complete"
            static let earnByDriver : String = API.BaseUrl + "driver/total-earn-by-driver"
            static let bankingDetailsDriver : String = API.BaseUrl + "driver/get-bank-details"
            static let getRatingList : String = API.BaseUrl + "driver/get-my-rating"
            static let getDriverPostRating : String = API.BaseUrl + "driver/post-rating"
            static let addBankDetails : String = API.BaseUrl + "driver/add-bank-details"
            
            static let sharePost : String = API.BaseUrl + "sharePost"                  // abhishek
            
           
            static let submitRating : String = API.BaseUrl + "submitRating"
          
           // static let getBookingList : String = API.BaseUrl + "getBookingList"

    
            static let getBanquetList : String = API.BaseUrl + "getBanquetList"
            static let ratingList : String = API.BaseUrl + "ratingList"
            static let getImages : String = API.BaseUrl + "getImages"
        }
        
        
        
        struct UserDefaults
        {
            
            static let userInfo : String = "User Info"
            static let token : String = "Token"
            static let authToken : String = "AuthToken"
            static let loginStatus : String = "LoginStatus"
            static let loginStatusSeeker : String = "SeekerLoginStatus"
            static let isEnableNotifification : String = "isEnableNotifification"
            static let isEnableSoundNotifification : String = "isEnableSoundNotifification"
            
        }
        
        struct StringConstant
        {
            static var appName : String {
                return "appName" }
            static var titleOptions: String {
                return "Title Options"
            }
            static var device : String {
                return"iOS" }
            static var lableName : String {
                return"lableName"}
            static var lableCity : String {
                return"lableCity" }
            static var lablePhone : String {
                return"lablePhone" }
            static var successful : String {
                return"successful" }
            static var titleSignup : String {
                return"titleSignup"}
            
            static var titleEditProfile : String {
                return"titleEditProfile" }
            
            static var titleForgetPassword : String {
                return"titleForgetPassword"}
            static var titleVerification : String {
                return"titleVerification" }
            
            static var ok : String {
                return"ok" }
            
            static var done : String {
                return"done" }
            static var camera : String {
                return"camera" }
            static var photoLibray : String {
                return"photoLibray" }
            static var cancel : String {
                return"cancel" }
            static var error : String {
                return"Error" }
        
            static var tryAgain : String {
                return"tryAgain" }
            static var selectAll  : String {
                return"selectAll" }
           
           
           
        }
        
        struct MessageConstant
        {
            static var termsCondition : String {
                return"termsCondition"}
            static var termsConditionSubString : String {
                return"termsConditionSubString" }
            static var forgetPassword : String {
                return"forgetPassword" }
            static var otp : String {
                return"otp"}
            static var requirereEnterPassword : String {
                return "requireOldPassword"}
            static var requirenewPassword : String {
                return "requirenewPassword"}
            static var resetPassword : String {
                return"resetPassword"}
            static var requireFirstName : String {
                return"requireFirstName" }
            static var requireLastName : String {
                return"requireLastName" }
            static var requirePhoneNumber : String {
                return"requirePhoneNumber" }
            static var requireAddress : String {
                return"requireAddress"}
            
            static var requireValidData : String {
                return"requireValidData"}
            static var requireMobile : String {
                return"requireMobile" }
            static var requireEmail : String {
                return"requireEmail" }
            static var requireValidEmail : String {
                return"requireValidEmail" }
            static var requireValidMobileNumber : String {
                return"requireValidMobileNumber" }
            static var requirePassword : String {
                return"requirePassword" }
            static var requireConfirmPassword : String {
                return"requireConfirmPassword" }
            static var requireMatchPassword : String {
                return"requireMatchPassword" }
            static var requireValidPassword : String {
                return"requireValidPassword"}
            static var requireSelectCity : String {
                return"requireSelectCity" }
            
            static var requireProfileImage : String {
                return"requireProfileImage" }
            
            
            static var requireDescription : String {
                return"requireDescription" }
           
            
            
            static var confirmLogout : String {
                return"confirmLogout"}
            static var warningPromocode : String {
                return"warningPromocode"}
            static var confirmDeleteEvent : String {
                return"confirmDeleteEvent" }
            static var oneCondition: String {
                return "Please enter email or mobile number"
            }
            static var samePassword: String {
                return "New Password and Re-enter New Password should be same."
            }
            
            static var requireDriverName: String {
                return "requireDriverName"
            }
            static var requireCompanyName: String {
                return "requireCompanyName"
            }
            static var requireModelName: String {
                return "requireModelName"
            }
            static var requirePlateNumber: String {
                return "requirePlateNumber"
            }
            static var requireVehicleColor: String {
                return "requirePlateNumber"
            }
            static var requireVehicleCategory: String {
                return "requireVehicleCategory"
            }
            static var requireVehicleSubCategory: String {
                return "requireVehicleSubCategory"
            }
        }
       
        struct FailureMessage
        {
            
            static var otpVerify : String {
                return"otpVerify"}
            static var login : String {
                return"login" }
        }
        struct KAlertMsg {
            static let otpMsg = "Enter all field"
        }
    }
}

@available(iOS 13.0, *)
@available(iOS 13.0, *)

extension UIViewController {


func showOkAlert(_ msg: String) {
       let alert = UIAlertController(title:
           "", message: msg, preferredStyle: .alert)
       let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
       alert.addAction(okAction)
       present(alert, animated: true, completion: nil)
   }
   
   func showOkAlertWithHandler(_ msg: String, handler: @escaping ()->Void){
       let alert = UIAlertController(title: "", message: msg, preferredStyle: .alert)
       let okAction = UIAlertAction(title: "OK", style: .default) { (type) -> Void in
           handler()
       }
       alert.addAction(okAction)
       present(alert, animated: true, completion: nil)
   }
    
    func loginAlertAction() {
        let alert = UIAlertController(title: "Login?", message: "You are not Login. Please Login First", preferredStyle: UIAlertController.Style.alert)
        
        
        alert.addAction(UIAlertAction(title: "Login",
                                      style: UIAlertAction.Style.destructive,
                                      handler: {(_: UIAlertAction!) in
                                        let VC: LoginViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                                        self.navigationController?.pushViewController(VC, animated: true)
                                        
                                        
                                        
                                        //Sign out action
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func ImageAlertAction() {
        let alert = UIAlertController(title: "Alert", message: "Image Url Not Found", preferredStyle: UIAlertController.Style.alert)
        
        
        alert.addAction(UIAlertAction(title: "Login",
                                      style: UIAlertAction.Style.destructive,
                                      handler: {(_: UIAlertAction!) in
                                        let VC: LoginViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                                        self.navigationController?.pushViewController(VC, animated: true)
                                        
                                        
                                        
                                        //Sign out action
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }

    

}
