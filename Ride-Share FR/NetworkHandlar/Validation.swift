//
//  SignUpViewController.swift
//  Haute Delivery
//
//  Created by Preeti malik on 05/06/19.
//  Copyright © 2019 Ashish Gupta. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps

//for failure and success results
enum ErrorAlert {
    case success
    case failure
    case error
}

//for success or failure of validation with alert message
enum isValid {
    case success
    case unknown
    case failure(ErrorAlert, AlertMessages)
}

enum Valid{
    case success
    case failure(String)
}

let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
let phoneRegex = "^[0-9]{6,15}$"
let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
let passwordRegex = "[A-Z0-9a-z._%@+-]{6,15}"
let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
let idValidation = "[A-Z0-9a-z._%@+-/*]{3,20}"
let idTest = NSPredicate(format: "SELF MATCHES %@", idValidation)

enum AlertMessages: String {
    case inValidEmail = "Please a enter valid email id"
    case invalidFirstLetterCaps = "First Letter should be capital"
    case inValidPhone = "Please enter a valid mobile Number"
    case invalidAlphabeticString = "Invalid String"
    case invalidAddress = "Please enter valid Email Adddress"
    case inValidPSW = "Password must be atleast 6 characters long"
    case emptyPhone = "Please enter mobile Number"
    case emptyEmployeeID = "Please enter Employee ID/Email ID"
    case emptyEmail = "Please enter Email Id"
    case enterPassword = "Please enter password"
    case passwordcount = "Password count must be between 6 to 15 characters"
    case validPassword = "Please enter valid password"
    case newPassword = "Please enter new password"
    case confirmPassword = "Please enter confirm password"
    case passwordNotMatch = "Password does not match"
    case oldPassword = "Please enter old password"
    case countryCode = "Please select a country code"
    // EditProfile
    case edEmptyFirstName = "Please enter First Name"
    case edEmptyLastName = "Please enter Last Name"
    case edEmptyAddress = "Please enter Service Area"
    case edIsValidEmail = " Please enter a valid Email id"
    case edEmptyMobileNo = "Please enter Mobile number."
    case edMobileNo = "Please enter a valid Phone number. "
    case edEmptyIdProofTitle = "Please enter Id Proof title"
    case edEmptyIdProofNumber = "Please enter Id Proof number"
    
    // Alert Message
    case alert = "Alert"
    case deleteAddress = "Do you want to delete an address"
    func localized() -> String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}

class Validation: NSObject {
    
    public static let shared = Validation()
    //SForgot Password Validation
    func ForgotPassword(_ mobileNumberOrEmail : String?, countryCode: String?) -> Valid {
        if (countryCode?.trim().isEmpty)! {
             return .failure(AlertMessages.countryCode.rawValue.localized())
        }
        if (mobileNumberOrEmail?.trim().isEmpty)! {
            return .failure(AlertMessages.emptyPhone.rawValue.localized())
        }
            if phoneTest.evaluate(with: mobileNumberOrEmail) == false {
                return .failure(AlertMessages.inValidPhone.rawValue.localized())
            }
        return .success
    }
    
    // login validation
    func validateLogin(_ mobileNumberOrEmail : String?, _ password: String?) -> Valid {
        if (mobileNumberOrEmail?.trim().isEmpty)! {
            return .failure(AlertMessages.emptyEmployeeID.rawValue.localized())
        }
        if (password?.trim().isEmpty)! {
            return .failure(AlertMessages.enterPassword.rawValue.localized())
        }
        return .success
    }

    // Change Password Validation
    func CreatePassword(_ password: String? , _ confirmPassword : String?) -> Valid {
        
        if (password?.trim().isEmpty)! {
            return .failure(AlertMessages.newPassword.rawValue.localized())
        }
        if (password?.trim().count)! < 6 {
            return .failure(AlertMessages.passwordcount.rawValue.localized())
        }
        if (confirmPassword?.trim().isEmpty)! {
            return .failure(AlertMessages.confirmPassword.rawValue.localized())
        }
        if !((password)?.trim().isEqual(confirmPassword))! {
            return .failure(AlertMessages.passwordNotMatch.rawValue.localized())
        }
        return .success
    }
    
    //Edit Profile Validation
    func validateSignUp(_ firstName : String?, _ lastName: String?, _ emailId: String?, _ mobileNumber: String?, _ serviceArea: String?, _ password:String?, _ countryCode:String?) -> Valid {
        if (firstName?.trim().isEmpty)! {
            return .failure(AlertMessages.edEmptyFirstName.rawValue.localized())
        }
        if (lastName?.trim().isEmpty)! {
            return .failure(AlertMessages.edEmptyLastName.rawValue.localized())
        }
        if countryCode?.trim() == "" {
            return .failure(AlertMessages.countryCode.rawValue.localized())
        }
        if (mobileNumber?.trim().isEmpty)! {
            return .failure(AlertMessages.emptyPhone.rawValue.localized())
        }
        if phoneTest.evaluate(with: mobileNumber) == false{
            return .failure(AlertMessages.edMobileNo.rawValue.localized())
        }
        if (emailId?.isEmpty)! {
            return .failure(AlertMessages.emptyEmail.rawValue.localized())
        }
        if emailTest.evaluate(with: emailId) == false{
            return .failure(AlertMessages.edIsValidEmail.rawValue.localized())
        }
        if (password?.trim().isEmpty)! {
            return .failure(AlertMessages.enterPassword.rawValue.localized())
        }
        if (password?.trim().count)! < 6 {
            return .failure(AlertMessages.passwordcount.rawValue.localized())
        }
        if serviceArea == "Service area" || serviceArea?.trim() == "" {
            return .failure(AlertMessages.edEmptyAddress.rawValue.localized())
        }
        return .success
    }
    
}

