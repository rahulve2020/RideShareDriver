//
//  AppServices.swift
//  Freeluancer
//
//  Created by Imran malik on 17/03/20.
//  Copyright © 2020 virtualEmployee. All rights reserved.
//

import Foundation
import UIKit
  
class AppServices: NSObject {
    
    typealias successBlock = (_ data : Any?) -> Void
    typealias failureBlock = (_ errorMsg : String) -> Void
    
    
    //MARK: Variables
    static let shared : AppServices = AppServices()
}

@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
extension AppServices{
    
    /**
     * Checks whether the status code is true(200)
     */
    func isSuccess(info : Dictionary<String,Any>) -> Bool
    {
        if let status = info["status"] as? Int, status == 200
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    /**
     * Returns the message to show as pop up getting from server
     */
    func getMesesage(info : Dictionary<String,Any>) -> String
    {
        if let msg = info["message"] as? String
        {
            return msg
        }
        else
        {
            return ""
        }
    }
    
//    func genrateChatoken(param : Dictionary<String,Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
//        ActivityIndicator.show()
//        ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.generateToken , parameters: param, requestName: "") { (json, error) in
//            ActivityIndicator.hide()
//
//            if error == nil
//            {
//
//                success(json)
//                return
//
//            }
//            else if error!.localizedDescription.contains("JSON could not be serialized"){
//                failure("Problem in connecting to Server. Please try again!")
//            }else{
//                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
//            }
//
//        }
//    }
    
    
    
    
    
    
    func registerUser(dicParam : Dictionary<String,Any>, success : @escaping (_ data : Any? , _ otp : String) -> Void, failure : @escaping failureBlock)
    {
        ActivityIndicator.show()
        ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.signUp, parameters: dicParam, requestName: "") { (json, error) in
            
            ActivityIndicator.hide()
            if error == nil
            {
                if self.isSuccess(info: json ?? Dictionary())
                {
                    print("jsonjsonjson:-",json)
                    
                    if let systemotp = json?["message"] as? String
                    {
                        success(json, systemotp.description)
                        return
                    }
                    
                    
                }else if let strMsg = json?["message"] as? String{
                    
                    failure(strMsg)
                    return
                }
            }
            
            if error!.localizedDescription.contains("JSON could not be serialized"){
                failure("Problem in connecting to Server. Please try again!")
            }else{
                var errorMsg : String = ""
                if let msg = json?["message"] as? String   {
                    errorMsg = msg
                }
                
                failure(error != nil ? error!.localizedDescription : errorMsg)
            }
        }
    }
    
    
    func resendSmsOtp(dicParam : Dictionary<String,Any>, success : @escaping (_ data : Any? , _ otp : String) -> Void, failure : @escaping failureBlock)
    {
        ActivityIndicator.show()
        ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.resendOtp, parameters: dicParam, requestName: "") { (json, error) in
            
            ActivityIndicator.hide()
            if error == nil
            {
                if self.isSuccess(info: json ?? Dictionary())
                {
                    print("jsonjsonjson:-",json)
                    
                    if let systemotp = json?["otp"] as? Int
                    {
                        success(json, systemotp.description)
                        return
                    }
                    
                    
                }else if let strMsg = json?["message"] as? String{
                    
                    failure(strMsg)
                    return
                }
            }
            
            else if error!.localizedDescription.contains("JSON could not be serialized"){
                failure("Problem in connecting to Server. Please try again!")
            }else{
                var errorMsg : String = ""
                if let msg = json?["message"] as? String   {
                    errorMsg = msg
                }
                
                failure(error != nil ? error!.localizedDescription : errorMsg)
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    //MARK:-
    func verifyOTP(param : Dictionary<String,Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
        ActivityIndicator.show()
        ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.otpVerify , parameters: param, requestName: "") { (json, error) in
            
            ActivityIndicator.hide()
            
            if error == nil
            {
                if self.isSuccess(info: json ?? Dictionary())
                {
                    
                    success(json)
                    //                    Facade.shared.isLogin = true
                    return
                }else if let strMsg = json?["message"] as? String{
                    failure(strMsg)
                    return
                }
            }
            else if error!.localizedDescription.contains("JSON could not be serialized"){
                failure("Problem in connecting to Server. Please try again!")
            }else{
                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
            }
            
        }
    }
    
    
    
    
    func login(param : Dictionary<String, Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
        ActivityIndicator.show()
        ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.login, parameters: param, requestName: "") { (json, error) in
            
            ActivityIndicator.hide()
            if error == nil
            {
                if self.isSuccess(info: json ?? Dictionary())
                {
                    let dataObj = json?["data"] as! [String : Any]
                    Facade.shared.isLogin = true
              //      let provider_seeker = dataObj["type"] as! String
                    
//                    if provider_seeker == "2"{
//                        Facade.shared.isLoginSeeker = true
//                        Facade.shared.isLogin = false
//                    }else{
//                        Facade.shared.isLogin = true
//                        Facade.shared.isLoginSeeker = false
//                    }
                    
                    success(json)
                    return
                }
                else if let strMsg = json?["message"] as? String{
                    failure(strMsg)
                    return
                }
            }
            if error!.localizedDescription.contains("JSON could not be serialized"){
                failure("Problem in connecting to Server. Please try again!")
            }else{
                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.login)
            }
            
            
        }
    }
    
    
    func forgotPassword(param : Dictionary<String, Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
        ActivityIndicator.show()
        ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.forgotPassword, parameters: param, requestName: "") { (json, error) in
            
            ActivityIndicator.hide()
            if error == nil
            {
                if self.isSuccess(info: json ?? Dictionary())
                {
                    success(json)
                    return
                }else if let strMsg = json?["message"] as? String{
                    failure(strMsg)
                    return
                }
            }
            if error!.localizedDescription.contains("JSON could not be serialized"){
                failure("Problem in connecting to Server. Please try again!")
            }else{
                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.login)
            }
        }
    }
    
    
        func rateUsApp(param : Dictionary<String,Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
            ActivityIndicator.show()
            ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.submitRating , parameters: param, requestName: "") { (json, error) in
    
                ActivityIndicator.hide()
    
                if error == nil
                {
                    if self.isSuccess(info: json ?? Dictionary())
                    {
                        success(json)
                        return
                    }else if let strMsg = json?["message"] as? String{
                        failure(strMsg)
                        return
                    }
                }
                else if error!.localizedDescription.contains("JSON could not be serialized"){
                    failure("Problem in connecting to Server. Please try again!")
                }else{
                    failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
                }
    
            }
        }
    
    
    
    func banqauetList(param : Dictionary<String,Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
        ActivityIndicator.show()
        ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.getBanquetList , parameters: param, requestName: "") { (json, error) in
            ActivityIndicator.hide()
            
            if error == nil
            {
                if self.isSuccess(info: json ?? Dictionary())
                {
                    success(json)
                    return
                }else if let strMsg = json?["message"] as? String{
                    failure(strMsg)
                    return
                }
            }
            else if error!.localizedDescription.contains("JSON could not be serialized"){
                failure("Problem in connecting to Server. Please try again!")
            }else{
                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
            }
            
        }
    }
    
func resetPassword(param : Dictionary<String,Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
    ActivityIndicator.show()
    ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.resetPassword , parameters: param, requestName: "") { (json, error) in
        
        ActivityIndicator.hide()
        if error == nil
        {
            if self.isSuccess(info: json ?? Dictionary())
            {
                success(json)
                return
            }else if let strMsg = json?["message"] as? String{
                failure(strMsg)
                return
            }
        }
            
        else if error!.localizedDescription.contains("JSON could not be serialized")
        {
            failure("Problem in connecting to Server. Please try again!")
        }else{
            failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
        }
    }
}
    
    
    func changePassword(param : Dictionary<String,Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
        ActivityIndicator.show()
        ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.changePassword , parameters: param, requestName: "") { (json, error) in
            
            ActivityIndicator.hide()
            if error == nil
            {
                if self.isSuccess(info: json ?? Dictionary())
                {
                    success(json)
                    return
                }else if let strMsg = json?["message"] as? String{
                    failure(strMsg)
                    return
                }
            }
                
            else if error!.localizedDescription.contains("JSON could not be serialized")
            {
                failure("Problem in connecting to Server. Please try again!")
            }else{
                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
            }
        }
    }
    
    func updateProfileDetails(param : Dictionary<String, Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
        ActivityIndicator.show()
        ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.updateProfile, parameters: param, requestName: "") { (json, error) in

            ActivityIndicator.hide()
            if error == nil
            {
                if self.isSuccess(info: json ?? Dictionary())
                {
                    success(json)
                    return
                }else if let strMsg = json?["message"] as? String{
                    failure(strMsg)
                    return
                }
            }
            if error!.localizedDescription.contains("JSON could not be serialized"){
                failure("Problem in connecting to Server. Please try again!")
            }else{
                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.login)
            }
        }
    }
    
    func editProfile(param : Dictionary<String, Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
        ActivityIndicator.show()
        ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.updateProfile, parameters: param, requestName: "") { (json, error) in
            
            ActivityIndicator.hide()
            if error == nil
            {
                if self.isSuccess(info: json ?? Dictionary())
                {
                    success(json)
                    return
                }else if let strMsg = json?["message"] as? String{
                    failure(strMsg)
                    return
                }
            }
            if error!.localizedDescription.contains("JSON could not be serialized"){
                failure("Problem in connecting to Server. Please try again!")
            }else{
                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.login)
            }
        }
    }

    
    func getDriverListing(param : Dictionary<String,Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
        ActivityIndicator.show()
        ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.getDriverList , parameters: param, requestName: "") { (json, error) in
            ActivityIndicator.hide()
            
            if error == nil
            {
                if self.isSuccess(info: json ?? Dictionary())
                {
                    success(json)
                    return
                }else if let strMsg = json?["message"] as? String{
                    failure(strMsg)
                    return
                }
            }
            else if error!.localizedDescription.contains("JSON could not be serialized"){
                failure("Problem in connecting to Server. Please try again!")
            }else{
                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
            }
            
        }
    }
    
    func getVehicleCategory(param : Dictionary<String,Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
        ActivityIndicator.show()
        ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.getVehicleCategoryList , parameters: param, requestName: "") { (json, error) in
            ActivityIndicator.hide()
            
            if error == nil
            {
                if self.isSuccess(info: json ?? Dictionary())
                {
                    success(json)
                    return
                }else if let strMsg = json?["message"] as? String{
                    failure(strMsg)
                    return
                }
            }
            else if error!.localizedDescription.contains("JSON could not be serialized"){
                failure("Problem in connecting to Server. Please try again!")
            }else{
                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
            }
            
        }
    }
    
    
    func getRatingList(param : Dictionary<String,Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
        ActivityIndicator.show()
        ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.ratingList , parameters: param, requestName: "") { (json, error) in
            ActivityIndicator.hide()
            
            if error == nil
            {
                if self.isSuccess(info: json ?? Dictionary())
                {
                    success(json)
                    return
                }else if let strMsg = json?["message"] as? String{
                    failure(strMsg)
                    return
                }
            }
            else if error!.localizedDescription.contains("JSON could not be serialized"){
                failure("Problem in connecting to Server. Please try again!")
            }else{
                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
            }
            
        }
    }
    func getImage(param : Dictionary<String,Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
        ActivityIndicator.show()
        ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.getImages , parameters: param, requestName: "") { (json, error) in
            ActivityIndicator.hide()
            
            if error == nil
            {
                if self.isSuccess(info: json ?? Dictionary())
                {
                    success(json)
                    return
                }else if let strMsg = json?["message"] as? String{
                    failure(strMsg)
                    return
                }
            }
            else if error!.localizedDescription.contains("JSON could not be serialized"){
                failure("Problem in connecting to Server. Please try again!")
            }else{
                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
            }
            
        }
    }

    func bookingCancelOrder(param : Dictionary<String,Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
        ActivityIndicator.show()
        ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.orderBookingCancel , parameters: param, requestName: "") { (json, error) in
            ActivityIndicator.hide()
            
            if error == nil
            {
                if self.isSuccess(info: json ?? Dictionary())
                {
                    success(json)
                    return
                }else if let strMsg = json?["message"] as? String{
                    failure(strMsg)
                    return
                }
            }
            else if error!.localizedDescription.contains("JSON could not be serialized"){
                failure("Problem in connecting to Server. Please try again!")
                print(error!.localizedDescription)
            }else{
                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
            }
            
        }
    }
    func getAddCardDetails(param : Dictionary<String,Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
        ActivityIndicator.show()
        ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.addCardDetails , parameters: param, requestName: "") { (json, error) in
            ActivityIndicator.hide()
            
            if error == nil
            {
                if self.isSuccess(info: json ?? Dictionary())
                {
                    success(json)
                    return
                }else if let strMsg = json?["message"] as? String{
                    failure(strMsg)
                    return
                }
            }
            else if error!.localizedDescription.contains("JSON could not be serialized"){
                failure("Problem in connecting to Server. Please try again!")
                print(error!.localizedDescription)
            }else{
                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
            }
            
        }
    }
//    
    
    
    
    func orderListing( success : @escaping successBlock, failure : @escaping failureBlock)  {
        ActivityIndicator.show()

        ServicesClass_New.getDataFromURlWith(url: Apphelper.Constants.API.getOrderListing, parameters: nil) { (json, error) in

            ActivityIndicator.hide()

            if error == nil
            {
                if self.isSuccess(info: json ?? Dictionary())
                {
                    success(json)
                    return
                }else if let strMsg = json?["message"] as? String{
                    failure(strMsg)
                    return
                }
            }
            else if error!.localizedDescription.contains("JSON could not be serialized"){
                failure("Problem in connecting to Server. Please try again!")
            }else{
                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
            }

        }

    }
    func orderListByDate(param : Dictionary<String,Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
        ActivityIndicator.show()
        ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.getOrderByDate , parameters: param, requestName: "") { (json, error) in
            
            ActivityIndicator.hide()
            if error == nil
            {
                if self.isSuccess(info: json ?? Dictionary())
                {
                    success(json)
                    return
                }else if let strMsg = json?["message"] as? String{
                    failure(strMsg)
                    return
                }
            }
                
            else if error!.localizedDescription.contains("JSON could not be serialized")
            {
                failure("Problem in connecting to Server. Please try again!")
            }else{
                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
            }
        }
    }

    func getPolicyData(param : Dictionary<String,Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
        ActivityIndicator.show()
        ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.getPolicy , parameters: param, requestName: "") { (json, error) in
            ActivityIndicator.hide()
            
            if error == nil
            {
                if self.isSuccess(info: json ?? Dictionary())
                {
                    success(json)
                    return
                }else if let strMsg = json?["message"] as? String{
                    failure(strMsg)
                    return
                }
            }
            else if error!.localizedDescription.contains("JSON could not be serialized"){
                failure("Problem in connecting to Server. Please try again!")
            }else{
                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
            }
            
        }
    }
    
    
    func helpSupport(param : Dictionary<String,Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
        ActivityIndicator.show()
        ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.helpAndSupport , parameters: param, requestName: "") { (json, error) in

            ActivityIndicator.hide()

            if error == nil
            {
                if self.isSuccess(info: json ?? Dictionary())
                {
                    success(json)
                    return
                }else if let strMsg = json?["message"] as? String{
                    failure(strMsg)
                    return
                }
            }
            else if error!.localizedDescription.contains("JSON could not be serialized"){
                failure("Problem in connecting to Server. Please try again!")
            }else{
                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
            }

        }
    }
    
    func getInTouch(param : Dictionary<String,Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
        ActivityIndicator.show()
        ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.getContactDetails , parameters: param, requestName: "") { (json, error) in
            
            ActivityIndicator.hide()
            if error == nil
            {
                if self.isSuccess(info: json ?? Dictionary())
                {
                    success(json)
                    return
                }else if let strMsg = json?["message"] as? String{
                    failure(strMsg)
                    return
                }
            }
                
            else if error!.localizedDescription.contains("JSON could not be serialized")
            {
                failure("Problem in connecting to Server. Please try again!")
            }else{
                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
            }
        }
    }
    func updateBanquetList(param : Dictionary<String,Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
        ActivityIndicator.show()
        ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.updateBanquet , parameters: param, requestName: "") { (json, error) in
            ActivityIndicator.hide()
            
            if error == nil
            {
                if self.isSuccess(info: json ?? Dictionary())
                {
                    success(json)
                    return
                }else if let strMsg = json?["message"] as? String{
                    failure(strMsg)
                    return
                }
            }
            else if error!.localizedDescription.contains("JSON could not be serialized"){
                failure("Problem in connecting to Server. Please try again!")
            }else{
                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
            }
            
        }
    }
    func getUserCardList( success : @escaping successBlock, failure : @escaping failureBlock)  {
        ActivityIndicator.show()
        
        ServicesClass_New.getDataFromURlWith(url: Apphelper.Constants.API.getUserCardList, parameters: nil) { (json, error) in
            
            ActivityIndicator.hide()
            
            if error == nil
            {
                
                if error == nil
                {
                    if self.isSuccess(info: json ?? Dictionary())
                    {
                        success(json)
                        return
                    }else if let strMsg = json?["message"] as? String{
                        failure(strMsg)
                        return
                    }
                }
                
            }
            else if error!.localizedDescription.contains("JSON could not be serialized"){
                failure("Problem in connecting to Server. Please try again!")
            }else{
                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
            }
            
        }
        
    }

    
    func getProfileDetails( success : @escaping successBlock, failure : @escaping failureBlock)  {
        ActivityIndicator.show()
        
        ServicesClass_New.getDataFromURlWith(url: Apphelper.Constants.API.getProfile, parameters: nil) { (json, error) in
            
            ActivityIndicator.hide()
            
            if error == nil
            {
                
                if error == nil
                {
                    if self.isSuccess(info: json ?? Dictionary())
                    {
                        success(json)
                        return
                    }else if let strMsg = json?["message"] as? String{
                        failure(strMsg)
                        return
                    }
                }
                
            }
            else if error!.localizedDescription.contains("JSON could not be serialized"){
                failure("Problem in connecting to Server. Please try again!")
            }else{
                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
            }
            
        }
        
    }

        func getRatingAndCommentList( success : @escaping successBlock, failure : @escaping failureBlock)  {
            ActivityIndicator.show()
    
            ServicesClass_New.getDataFromURlWith(url: Apphelper.Constants.API.getRatingList, parameters: nil) { (json, error) in
    
                ActivityIndicator.hide()
    
                if error == nil
                {
                    if self.isSuccess(info: json ?? Dictionary())
                    {
                        success(json)
                        return
                    }else if let strMsg = json?["message"] as? String{
                        failure(strMsg)
                        return
                    }
                }
                else if error!.localizedDescription.contains("JSON could not be serialized"){
                    failure("Problem in connecting to Server. Please try again!")
                }else{
                    failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
                }
    
            }
    
        }
//   
//    func saveDataOnEditProfile(param : Dictionary<String,Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
//        ActivityIndicator.show()
//        ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.edit_profile , parameters: param, requestName: "") { (json, error) in
//            
//            ActivityIndicator.hide()
//            
//            if error == nil
//            {
//                if self.isSuccess(info: json ?? Dictionary())
//                {
//                    success(json)
//                    return
//                }else if let strMsg = json?["message"] as? String{
//                    failure(strMsg)
//                    return
//                }
//            }
//            else if error!.localizedDescription.contains("JSON could not be serialized"){
//                failure("Problem in connecting to Server. Please try again!")
//            }else{
//                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
//            }
//            
//        }
//    }
//    
//    func changePassword(param : Dictionary<String,Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
//        ActivityIndicator.show()
//        ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.changePassword , parameters: param, requestName: "") { (json, error) in
//            
//            ActivityIndicator.hide()
//            if error == nil
//            {
//                if self.isSuccess(info: json ?? Dictionary())
//                {
//                    success(json)
//                    return
//                }else if let strMsg = json?["message"] as? String{
//                    failure(strMsg)
//                    return
//                }
//            }
//                
//            else if error!.localizedDescription.contains("JSON could not be serialized")
//            {
//                failure("Problem in connecting to Server. Please try again!")
//            }else{
//                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
//            }
//        }
//    }
//    
//    func getProposalDetilsFromServer(param : Dictionary<String,Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
//        ActivityIndicator.show()
//        ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.proposals_details , parameters: param, requestName: "") { (json, error) in
//            ActivityIndicator.hide()
//            if error == nil
//            {
//                if self.isSuccess(info: json ?? Dictionary())
//                {
//                    success(json)
//                    return
//                }else if let strMsg = json?["message"] as? String{
//                    failure(strMsg)
//                    return
//                }
//            }
//            else if error!.localizedDescription.contains("JSON could not be serialized"){
//                failure("Problem in connecting to Server. Please try again!")
//                print(error!.localizedDescription)
//            }else{
//                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
//                
//                // print(localizedDescription)
//            }
//            
//        }
//    }
//    
//    func getDeliveredProjectDetilsFromServer(param : Dictionary<String,Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
//        ActivityIndicator.show()
//        
//        ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.get_job_detail , parameters: param, requestName: "") { (json, error) in
//            
//            ActivityIndicator.hide()
//            
//            if error == nil
//            {
//                if self.isSuccess(info: json ?? Dictionary())
//                {
//                    success(json)
//                    return
//                }else if let strMsg = json?["message"] as? String{
//                    failure(strMsg)
//                    return
//                }
//            }
//            else if error!.localizedDescription.contains("JSON could not be serialized"){
//                failure("Problem in connecting to Server. Please try again!")
//            }else{
//                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
//            }
//            
//        }
//    }
//    
//    func getVideoReviewDetilsFromServer(param : Dictionary<String,Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
//        ActivityIndicator.show()
//        
//        ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.request_review, parameters: param, requestName: "") { (json, error) in
//            
//            ActivityIndicator.hide()
//            
//            if error == nil
//            {
//                if self.isSuccess(info: json ?? Dictionary())
//                {
//                    success(json)
//                    return
//                }else if let strMsg = json?["message"] as? String{
//                    failure(strMsg)
//                    return
//                }
//            }
//            else if error!.localizedDescription.contains("JSON could not be serialized"){
//                failure("Problem in connecting to Server. Please try again!")
//            }else{
//                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
//            }
//            
//        }
//    }
//    
//    
//    
//    func getProjectDetilsFromServer(param : Dictionary<String,Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
//        ActivityIndicator.show()
//        
//        ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.project_detail, parameters: param, requestName: "") { (json, error) in
//            
//            ActivityIndicator.hide()
//            
//            if error == nil
//            {
//                if self.isSuccess(info: json ?? Dictionary())
//                {
//                    success(json)
//                    return
//                }else if let strMsg = json?["message"] as? String{
//                    failure(strMsg)
//                    return
//                }
//            }
//            else if error!.localizedDescription.contains("JSON could not be serialized"){
//                failure("Problem in connecting to Server. Please try again!")
//            }else{
//                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
//            }
//            
//        }
//    }
//    
//    func getProjectDeliveredDetilsFromServer(param : Dictionary<String,Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
//        ActivityIndicator.show()
//        ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.dilivered_project , parameters: param, requestName: "") { (json, error) in
//            
//            ActivityIndicator.hide()
//            
//            if error == nil
//            {
//                if self.isSuccess(info: json ?? Dictionary())
//                {
//                    success(json)
//                    return
//                }else if let strMsg = json?["message"] as? String{
//                    failure(strMsg)
//                    return
//                }
//            }
//            else if error!.localizedDescription.contains("JSON could not be serialized"){
//                failure("Problem in connecting to Server. Please try again!")
//            }else{
//                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
//            }
//            
//        }
//    }
//    
//    func getJobDetilsFromServer(param : Dictionary<String,Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
//        ActivityIndicator.show()
//        
//        ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.get_job_detail , parameters: param, requestName: "") { (json, error) in
//            
//            ActivityIndicator.hide()
//            
//            if error == nil
//            {
//                if self.isSuccess(info: json ?? Dictionary())
//                {
//                    success(json)
//                    return
//                }else if let strMsg = json?["message"] as? String{
//                    failure(strMsg)
//                    return
//                }
//            }
//            else if error!.localizedDescription.contains("JSON could not be serialized"){
//                failure("Problem in connecting to Server. Please try again!")
//            }else{
//                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
//            }
//            
//        }
//    }
//    
//    func getAppliedProjectDetailFromServer(param : Dictionary<String,Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
//        ActivityIndicator.show()
//        
//        ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.applied_projects, parameters: param, requestName: "") { (json, error) in
//            
//            ActivityIndicator.hide()
//            
//            if error == nil
//            {
//                if self.isSuccess(info: json ?? Dictionary())
//                {
//                    success(json)
//                    return
//                }else if let strMsg = json?["message"] as? String{
//                    failure(strMsg)
//                    return
//                }
//            }
//            else if error!.localizedDescription.contains("JSON could not be serialized"){
//                failure("Problem in connecting to Server. Please try again!")
//            }else{
//                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
//            }
//            
//        }
//    }
//    
//    func getBidFromServer(param : Dictionary<String,Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
//        ActivityIndicator.show()
//        
//        ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.get_bid, parameters: param, requestName: "") { (json, error) in
//            
//            ActivityIndicator.hide()
//            
//            if error == nil
//            {
//                if self.isSuccess(info: json ?? Dictionary())
//                {
//                    success(json)
//                    return
//                }else if let strMsg = json?["message"] as? String{
//                    failure(strMsg)
//                    return
//                }
//            }
//            else if error!.localizedDescription.contains("JSON could not be serialized"){
//                failure("Problem in connecting to Server. Please try again!")
//            }else{
//                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
//            }
//            
//        }
//    }
//    
//    
//    func visitUserProfile(param : Dictionary<String,Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
//        ActivityIndicator.show()
//        ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.visit_profile , parameters: param, requestName: "") { (json, error) in
//            
//            ActivityIndicator.hide()
//            
//            if error == nil
//            {
//                if self.isSuccess(info: json ?? Dictionary())
//                {
//                    success(json)
//                    return
//                }else if let strMsg = json?["message"] as? String{
//                    failure(strMsg)
//                    return
//                }
//            }
//            else if error!.localizedDescription.contains("JSON could not be serialized"){
//                failure("Problem in connecting to Server. Please try again!")
//            }else{
//                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
//            }
//            
//        }
//    }
//    
//    func getProjectDetailFronServer(param : Dictionary<String,Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
//        ActivityIndicator.show()
//        ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.visit_profile , parameters: param, requestName: "") { (json, error) in
//            
//            ActivityIndicator.hide()
//            
//            if error == nil
//            {
//                if self.isSuccess(info: json ?? Dictionary())
//                {
//                    success(json)
//                    return
//                }else if let strMsg = json?["message"] as? String{
//                    failure(strMsg)
//                    return
//                }
//            }
//            else if error!.localizedDescription.contains("JSON could not be serialized"){
//                failure("Problem in connecting to Server. Please try again!")
//            }else{
//                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
//            }
//            
//        }
//    }
//    
//    
//    
//    
//    

//    
//    func viewProfileFromOnGoingDetail(param : Dictionary<String,Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
//        ActivityIndicator.show()
//        ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.view_profile , parameters: param, requestName: "") { (json, error) in
//            
//            ActivityIndicator.hide()
//            
//            if error == nil
//            {
//                if self.isSuccess(info: json ?? Dictionary())
//                {
//                    success(json)
//                    return
//                }else if let strMsg = json?["message"] as? String{
//                    failure(strMsg)
//                    return
//                }
//            }
//            else if error!.localizedDescription.contains("JSON could not be serialized"){
//                failure("Problem in connecting to Server. Please try again!")
//            }else{
//                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
//            }
//            
//        }
//    }
//    
//    func contactUs(param : Dictionary<String,Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
//        ActivityIndicator.show()
//        ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.contact_us , parameters: param, requestName: "") { (json, error) in
//            
//            ActivityIndicator.hide()
//            
//            if error == nil
//            {
//                if self.isSuccess(info: json ?? Dictionary())
//                {
//                    success(json)
//                    return
//                }else if let strMsg = json?["message"] as? String{
//                    failure(strMsg)
//                    return
//                }
//            }
//            else if error!.localizedDescription.contains("JSON could not be serialized"){
//                failure("Problem in connecting to Server. Please try again!")
//            }else{
//                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
//            }
//        }
//    }
//    
//    func getProposalListingFromServer(param : Dictionary<String,Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
//        ActivityIndicator.show()
//        ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.proposals_listing , parameters: param, requestName: "") { (json, error) in
//            
//            ActivityIndicator.hide()
//            
//            if error == nil
//            {
//                if self.isSuccess(info: json ?? Dictionary())
//                {
//                    success(json)
//                    return
//                }else if let strMsg = json?["message"] as? String{
//                    failure(strMsg)
//                    return
//                }
//            }
//            else if error!.localizedDescription.contains("JSON could not be serialized"){
//                failure("Problem in connecting to Server. Please try again!")
//            }else{
//                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
//            }
//            
//        }
//    }
//    
//    
//    func getListingStories(param : Dictionary<String,Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
//        ActivityIndicator.show()
//        ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.listing_stories, parameters: param, requestName: "") { (json, error) in
//            
//            ActivityIndicator.hide()
//            
//            if error == nil
//            {
//                if self.isSuccess(info: json ?? Dictionary())
//                {
//                    success(json)
//                    return
//                }else if let strMsg = json?["message"] as? String{
//                    failure(strMsg)
//                    return
//                }
//            }
//            else if error!.localizedDescription.contains("JSON could not be serialized"){
//                failure("Problem in connecting to Server. Please try again!")
//            }else{
//                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
//            }
//            
//        }
//    }
//    
//    func reactStories(param : Dictionary<String,Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
//        ActivityIndicator.show()
//        ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.react_stories, parameters: param, requestName: "") { (json, error) in
//            
//            ActivityIndicator.hide()
//            
//            if error == nil
//            {
//                if self.isSuccess(info: json ?? Dictionary())
//                {
//                    success(json)
//                    return
//                }else if let strMsg = json?["message"] as? String{
//                    failure(strMsg)
//                    return
//                }
//            }
//            else if error!.localizedDescription.contains("JSON could not be serialized"){
//                failure("Problem in connecting to Server. Please try again!")
//            }else{
//                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
//            }
//            
//        }
//    }
//    
//    
//    
//    func getLinkeinConnect(param : Dictionary<String,Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
//        ActivityIndicator.show()
//        ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.contactLinkedIn, parameters: param, requestName: "") { (json, error) in
//            
//            ActivityIndicator.hide()
//            
//            if error == nil
//            {
//                if self.isSuccess(info: json ?? Dictionary())
//                {
//                    success(json)
//                    return
//                }else if let strMsg = json?["message"] as? String{
//                    failure(strMsg)
//                    return
//                }
//            }
//            else if error!.localizedDescription.contains("JSON could not be serialized"){
//                failure("Problem in connecting to Server. Please try again!")
//            }else{
//                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
//            }
//            
//        }
//    }
//    
//    func getDeletePortListing(param : Dictionary<String,Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
//        ActivityIndicator.show()
//        ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.delete_portfolio , parameters: param, requestName: "") { (json, error) in
//            
//            ActivityIndicator.hide()
//            
//            if error == nil
//            {
//                if self.isSuccess(info: json ?? Dictionary())
//                {
//                    success(json)
//                    return
//                }else if let strMsg = json?["message"] as? String{
//                    failure(strMsg)
//                    return
//                }
//            }
//            else if error!.localizedDescription.contains("JSON could not be serialized"){
//                failure("Problem in connecting to Server. Please try again!")
//            }else{
//                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
//            }
//            
//        }
//    }
//    
//    func getPortFolio(param : Dictionary<String,Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
//        ActivityIndicator.show()
//        ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.add_portfolio , parameters: param, requestName: "") { (json, error) in
//            
//            ActivityIndicator.hide()
//            
//            if error == nil
//            {
//                if self.isSuccess(info: json ?? Dictionary())
//                {
//                    success(json)
//                    return
//                }else if let strMsg = json?["message"] as? String{
//                    failure(strMsg)
//                    return
//                }
//            }
//            else if error!.localizedDescription.contains("JSON could not be serialized"){
//                failure("Problem in connecting to Server. Please try again!")
//            }else{
//                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
//            }
//            
//        }
//    }
//    
//    func UploadPortfoliio( imageArray : Data,success : @escaping successBlock, failure : @escaping failureBlock)  {
//        ActivityIndicator.show()
//        ServicesClass_New.uploadPortFolioOnSerer( imageData: imageArray) { (json, error) in
//            
//            ActivityIndicator.hide()
//            print("jsonjsonjsonjson:-\(json)")
//            if error == nil
//            {
//                if self.isSuccess(info: json ?? Dictionary())
//                {
//                    success(json)
//                    return
//                }else if let strMsg = json?["message"] as? String{
//                    failure(strMsg)
//                    return
//                }
//            }
//            else if error!.localizedDescription.contains("JSON could not be serialized"){
//                failure("Problem in connecting to Server. Please try again!")
//            }else{
//                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
//            }
//            
//        }
//        
//    }
//    
//    func UploadPortfoliioServer(param : Dictionary<String,Any>,imageArray : [Data], success : @escaping successBlock, failure : @escaping failureBlock) {
//        
//        ServicesClass_New.uploadPortFolioOnServerWithAlamofire(parameters: param, imageArray: imageArray) { (json, error) in
//            ActivityIndicator.hide()
//            if error == nil
//            {
//                if self.isSuccess(info: json ?? Dictionary()) {
//                    success(json)
//                    return
//                }else if let strMsg = json?["message"] as? String{
//                    failure(strMsg)
//                    return
//                }
//            }
//            
//            if error!.localizedDescription.contains("JSON could not be serialized"){
//                failure("Problem in connecting to Server. Please try again!")
//            }else{
//                failure(error != nil ? error!.localizedDescription : self.getMesesage(info: json ?? Dictionary()))
//            }
//        }
//        
//    }
//    
//    
    func UploadNewStories( imageArray : [Data],success : @escaping successBlock, failure : @escaping failureBlock)  {
        ActivityIndicator.show()
        ServicesClass_New.uploadSingleImageWithAlamofire( imageData: imageArray) { (json, error) in
            
            ActivityIndicator.hide()
            print("jsonjsonjsonjson:-\(json)")
            if error == nil
            {
                if self.isSuccess(info: json ?? Dictionary())
                {
                    success(json)
                    return
                }else if let strMsg = json?["message"] as? String{
                    failure(strMsg)
                    return
                }
            }
            else if error!.localizedDescription.contains("JSON could not be serialized"){
                failure("Problem in connecting to Server. Please try again!")
            }else{
                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
            }
            
        }
        
    }

    func updateProfile(param : Dictionary<String,Any>,imageArray : [Data], success : @escaping successBlock, failure : @escaping failureBlock) {
        ActivityIndicator.show()
        
        ServicesClass_New.uploadProfileImageWithAlamofire(parameters: param, imageArray: imageArray) { (json, error) in
            ActivityIndicator.hide()
            if error == nil
            {
                if self.isSuccess(info: json ?? Dictionary()) {
                    success(json)
                    return
                }else if let strMsg = json?["message"] as? String{
                    failure(strMsg)
                    return
                }
            }
            
            if error?.localizedDescription.contains("JSON could not be serialized") ?? false{
                failure("Problem in connecting to Server. Please try again!")
            }else{
                failure(error != nil ? error!.localizedDescription : self.getMesesage(info: json ?? Dictionary()))
            }
        }
        
    }
//    
//    func uploadNewProject(image : Array<UIImage>, param : Dictionary<String,Any>, success : @escaping successBlock, failure : @escaping failureBlock) {
//        
//        ActivityIndicator.show()
//        ServicesClass_New.uploadProject(url:  Apphelper.Constants.API.add_project, parameters: param, requestName: "", arrImg: image, arrVideos: []) { (json, error) in
//            
//            ActivityIndicator.hide()
//            
//            if error == nil
//            {
//                if self.isSuccess(info: json ?? Dictionary())
//                {
//                    success(json ?? Dictionary())
//                    return
//                }else if let strMsg = json?["message"] as? String{
//                    failure(strMsg)
//                    return
//                }
//            } else if error!.localizedDescription.contains("JSON could not be serialized"){
//                failure("Problem in connecting to Server. Please try again!")
//            }else{
//                failure(error != nil ? error!.localizedDescription : self.getMesesage(info: json ?? Dictionary()))
//            }
//        }
//        
//    }
//    
//    
//
//
//    func uploadPost(image : Array<UIImage>, success : @escaping successBlock, failure : @escaping failureBlock) {
//
//        ActivityIndicator.show()
//        ServicesClass_New.uploadData(url:  Apphelper.Constants.API.providers_posts, parameters: ["" : ""], requestName: "", arrImg: image, arrVideos: []) { (json, error) in
//
//            ActivityIndicator.hide()
//
//            if error == nil
//            {
//                if self.isSuccess(info: json ?? Dictionary())
//                {
//                    success(json ?? Dictionary())
//                    return
//                }else if let strMsg = json?["message"] as? String{
//                    failure(strMsg)
//                    return
//                }
//            } else if error!.localizedDescription.contains("JSON could not be serialized"){
//                failure("Problem in connecting to Server. Please try again!")
//            }else{
//                failure(error != nil ? error!.localizedDescription : self.getMesesage(info: json ?? Dictionary()))
//            }
//        }
//
//    }
//
//    func CreatePost(param : Dictionary<String,Any>,imageArray : [Data], success : @escaping successBlock, failure : @escaping failureBlock) {
//        ActivityIndicator.show()
//        ServicesClass_New.uploadImageCreatPostWithAlamofire(parameters: param, imageArray: imageArray) { (json, error) in
//            ActivityIndicator.hide()
//            if error == nil
//            {
//                if self.isSuccess(info: json ?? Dictionary()) {
//                    success(json)
//                    return
//                }else if let strMsg = json?["message"] as?  String{
//                    failure(strMsg)
//                    return
//                }
//            }
//            
//            if error?.localizedDescription.contains("JSON could not be serialized") ?? false{
//                failure("Problem in connecting to Server. Please try again!")
//            }else{
//                failure(error != nil ? error!.localizedDescription : self.getMesesage(info: json ?? Dictionary()))
//            }
//        }
//        
//    }
//    //   abhishek    22/11/021
////    func CreateHashtagPost(param : Dictionary<String,Any>,imageArray : [Data], success : @escaping successBlock, failure : @escaping failureBlock) {
////        ActivityIndicator.show()
////        ServicesClass_New.uploadImageCreatPostWithAlamofire(parameters: param, imageArray: imageArray) { (json, error) in
////            ActivityIndicator.hide()
////            if error == nil
////            {
////                if self.isSuccess(info: json ?? Dictionary()) {
////                    success(json)
////                    return
////                }else if let strMsg = json?["message"] as?  String{
////                    failure(strMsg)
////                    return
////                }
////            }
////
////            if error?.localizedDescription.contains("JSON could not be serialized") ?? false{
////                failure("Problem in connecting to Server. Please try again!")
////            }else{
////                failure(error != nil ? error!.localizedDescription : self.getMesesage(info: json ?? Dictionary()))
////            }
////        }
////
////    }
//    
//    func UploadFile(param : Dictionary<String,Any>,imageArray : [Data], success : @escaping successBlock, failure : @escaping failureBlock) {
//        
//        ServicesClass_New.uploadfileWithAlamofire(parameters: param, imageArray: imageArray) { (json, error) in
//            ActivityIndicator.hide()
//            if error == nil
//            {
//                if self.isSuccess(info: json ?? Dictionary()) {
//                    success(json)
//                    return
//                }else if let strMsg = json?["message"] as? String{
//                    failure(strMsg)
//                    return
//                }
//            }
//            
//            if error?.localizedDescription.contains("JSON could not be serialized") ?? false{
//                failure("Problem in connecting to Server. Please try again!")
//            }else{
//                failure(error != nil ? error!.localizedDescription : self.getMesesage(info: json ?? Dictionary()))
//            }
//        }
//        
//    }
//    
////    func UploadProjectFile(param : Dictionary<String,Any>,imageArray : [Data], success : @escaping successBlock, failure : @escaping failureBlock) {
////
////        ServicesClass_New.submitProjectFileWithAlamofire(parameters: param, imageArray: imageArray) { (json, error) in
//
//    
//    func UploadProjectFile(param : Dictionary<String,Any>, videoKey: String? = nil , imageArray : [URL],success : @escaping successBlock, failure : @escaping failureBlock)  {
//        ActivityIndicator.show()
//        
//        ServicesClass_New.submitProjectFileWithAlamofire(parameters: param, videoKey: videoKey,imageArray:imageArray ) { (json, error) in
//            
//            ActivityIndicator.hide()
//            if error == nil
//            {
//                if self.isSuccess(info: json ?? Dictionary()) {
//                    success(json)
//                    return
//                }else if let strMsg = json?["message"] as? String{
//                    failure(strMsg)
//                    return
//                }
//            }
//            
//            if error?.localizedDescription.contains("JSON could not be serialized") ?? false{
//                failure("Problem in connecting to Server. Please try again!")
//            }else{
//                failure(error != nil ? error!.localizedDescription : self.getMesesage(info: json ?? Dictionary()))
//            }
//        }
//        
//    }
//    
//    
//    func UploadVideoByReviw(param : Dictionary<String,Any>,videoKey : String ,imageArray : [Data],success : @escaping successBlock, failure : @escaping failureBlock)  {
//        ActivityIndicator.show()
//        
//        ServicesClass_New.uploadVideoWithAlamofire(parameters: param, videoData: imageArray, videoKey: videoKey) { (json, error) in
//            
//            ActivityIndicator.hide()
//            print("jsonjsonjsonjson:-\(json)")
//            if error == nil
//            {
//                if self.isSuccess(info: json ?? Dictionary())
//                {
//                    success(json)
//                    return
//                }else if let strMsg = json?["message"] as? String{
//                    failure(strMsg)
//                    return
//                }
//            }
//            else if error!.localizedDescription.contains("JSON could not be serialized"){
//                failure("Problem in connecting to Server. Please try again!")
//            }else{
//                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
//            }
//            
//        }
//    }
//    
//    func getJobProfileListFromServer( success : @escaping successBlock, failure : @escaping failureBlock)  {
//        ActivityIndicator.show()
//        
//        ServicesClass_New.getDataFromURlWith(url: Apphelper.Constants.API.get_job_profile, parameters: nil) { (json, error) in
//            
//            ActivityIndicator.hide()
//            
//            if error == nil
//            {
//                if self.isSuccess(info: json ?? Dictionary())
//                {
//                    success(json)
//                    return
//                }else if let strMsg = json?["message"] as? String{
//                    failure(strMsg)
//                    return
//                }
//            }
//            else if error!.localizedDescription.contains("JSON could not be serialized"){
//                failure("Problem in connecting to Server. Please try again!")
//            }else{
//                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
//            }
//            
//        }
//        
//    }
//    
//    
//    func addLanguageServer(param : Dictionary<String,Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
//        ActivityIndicator.show()
//        
//        ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.add_language, parameters: param, requestName: "") { (json, error) in
//            
//            ActivityIndicator.hide()
//            
//            if error == nil
//            {
//                if self.isSuccess(info: json ?? Dictionary())
//                {
//                    success(json)
//                    return
//                }else if let strMsg = json?["message"] as? String{
//                    failure(strMsg)
//                    return
//                }
//            }
//            else if error!.localizedDescription.contains("JSON could not be serialized"){
//                failure("Problem in connecting to Server. Please try again!")
//            }else{
//                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
//            }
//            
//        }
//    }
//    
//    
//    func getlanguageFromServer( success : @escaping successBlock, failure : @escaping failureBlock)  {
//        ActivityIndicator.show()
//        
//        ServicesClass_New.getDataFromURlWith(url: Apphelper.Constants.API.language_listing, parameters: nil) { (json, error) in
//            
//            ActivityIndicator.hide()
//            
//            if error == nil
//            {
//                if self.isSuccess(info: json ?? Dictionary())
//                {
//                    success(json)
//                    return
//                }else if let strMsg = json?["message"] as? String{
//                    failure(strMsg)
//                    return
//                }
//            }
//            else if error!.localizedDescription.contains("JSON could not be serialized"){
//                failure("Problem in connecting to Server. Please try again!")
//            }else{
//                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
//            }
//            
//        }
//        
//    }
//    
//    func getFAQListFromServer( success : @escaping successBlock, failure : @escaping failureBlock)  {
//        ActivityIndicator.show()
//        
//        ServicesClass_New.getDataFromURlWith(url: Apphelper.Constants.API.faq_listing, parameters: nil) { (json, error) in
//            
//            ActivityIndicator.hide()
//            
//            if error == nil
//            {
//                if self.isSuccess(info: json ?? Dictionary())
//                {
//                    success(json)
//                    return
//                }else if let strMsg = json?["message"] as? String{
//                    failure(strMsg)
//                    return
//                }
//            }
//            else if error!.localizedDescription.contains("JSON could not be serialized"){
//                failure("Problem in connecting to Server. Please try again!")
//            }else{
//                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
//            }
//            
//        }
//        
//    }
//    
//    
//    func getNotificationListFromServer( success : @escaping successBlock, failure : @escaping failureBlock)  {
//        ActivityIndicator.show()
//        
//        ServicesClass_New.getDataFromURlWith(url: Apphelper.Constants.API.notficationPost, parameters: nil) { (json, error) in
//            
//            ActivityIndicator.hide()
//            
//            if error == nil
//            {
//                if self.isSuccess(info: json ?? Dictionary())
//                {
//                    success(json)
//                    return
//                }else if let strMsg = json?["message"] as? String{
//                    failure(strMsg)
//                    return
//                }
//            }
//            else if error!.localizedDescription.contains("JSON could not be serialized"){
//                failure("Problem in connecting to Server. Please try again!")
//            }else{
//                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
//            }
//            
//        }
//        
//    }
//    
//    func getSeekerNotificationListFromServer( success : @escaping successBlock, failure : @escaping failureBlock)  {
//        ActivityIndicator.show()
//        
//        ServicesClass_New.getDataFromURlWith(url: Apphelper.Constants.API.notficationPost, parameters: nil) { (json, error) in
//            
//            ActivityIndicator.hide()
//            
//            if error == nil
//            {
//                if self.isSuccess(info: json ?? Dictionary())
//                {
//                    success(json)
//                    return
//                }else if let strMsg = json?["message"] as? String{
//                    failure(strMsg)
//                    return
//                }
//            }
//            else if error!.localizedDescription.contains("JSON could not be serialized"){
//                failure("Problem in connecting to Server. Please try again!")
//            }else{
//                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
//            }
//            
//        }
//        
//    }
//    //abhishek 12/11/021
//    func AcceptFollow(param : Dictionary<String,Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
//        ActivityIndicator.show()
//        ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.acceptFollow, parameters: param, requestName: "") { (json, error) in
//            ActivityIndicator.hide()
//            
//            if error == nil
//            {
//                if self.isSuccess(info: json ?? Dictionary())
//                {
//                    success(json)
//                    
//                    return
//                }else if let strMsg = json?["message"] as? String{
//                    failure(strMsg)
//                    return
//                }
//            }
//            else if error!.localizedDescription.contains("JSON could not be serialized"){
//                failure("Problem in connecting to Server. Please try again!")
//            }else{
//                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
//            }
//            
//        }
//    }
//    
//    func getFollowersListFromServer(param : Dictionary<String,Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
//        ActivityIndicator.show()
//        
//        ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.follower_following_list , parameters: param, requestName: "") { (json, error) in
//            
//            ActivityIndicator.hide()
//            
//            if error == nil
//            {
//                if self.isSuccess(info: json ?? Dictionary())
//                {
//                    success(json)
//                    return
//                }else if let strMsg = json?["message"] as? String{
//                    failure(strMsg)
//                    return
//                }
//            }
//            else if error!.localizedDescription.contains("JSON could not be serialized"){
//                failure("Problem in connecting to Server. Please try again!")
//            }else{
//                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
//            }
//            
//        }
//        
//    }
//    
//    func getFollowListFromServer(param : Dictionary<String,Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
//        ActivityIndicator.show()
//        
//        ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.follow , parameters: param, requestName: "") { (json, error) in
//            
//            ActivityIndicator.hide()
//            
//            if error == nil
//            {
//                if self.isSuccess(info: json ?? Dictionary())
//                {
//                    success(json)
//                    return
//                }else if let strMsg = json?["message"] as? String{
//                    failure(strMsg)
//                    return
//                }
//            }
//            else if error!.localizedDescription.contains("JSON could not be serialized"){
//                failure("Problem in connecting to Server. Please try again!")
//            }else{
//                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
//            }
//            
//        }
//       
//    }
//    
//    func notificationStatusFromServer(param : Dictionary<String,Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
//        ActivityIndicator.show()
//        
//        ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.notification_status , parameters: param, requestName: "") { (json, error) in
//            
//            ActivityIndicator.hide()
//            
//            if error == nil
//            {
//                if self.isSuccess(info: json ?? Dictionary())
//                {
//                    success(json)
//                    return
//                }else if let strMsg = json?["notification_satus"] as? Int{
//                    let str  = String("\(strMsg)")
//                    failure(str)
//                    return
//                }
//            }
//            else if error!.localizedDescription.contains("JSON could not be serialized"){
//                failure("Problem in connecting to Server. Please try again!")
//            }else{
//                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
//            }
//        }
//    }
//    
//    func profilePrivacy(param : Dictionary<String,Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
//        ActivityIndicator.show()
//        
//        ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.profilePrivacyStatus , parameters: param, requestName: "") { (json, error) in
//            
//            ActivityIndicator.hide()
//            
//            if error == nil
//            {
//                if self.isSuccess(info: json ?? Dictionary())
//                {
//                    success(json)
//                    return
//                }else if let strMsg = json?["notification_satus"] as? Int{
//                    let str  = String("\(strMsg)")
//                    failure(str)
//                    return
//                }
//            }
//            else if error!.localizedDescription.contains("JSON could not be serialized"){
//                failure("Problem in connecting to Server. Please try again!")
//            }else{
//                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
//            }
//        }
//    }
//    
//    func availableforProject(param : Dictionary<String,Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
//        ActivityIndicator.show()
//        
//        ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.availableforProject , parameters: param, requestName: "") { (json, error) in
//            
//            ActivityIndicator.hide()
//            
//            if error == nil
//            {
//                if self.isSuccess(info: json ?? Dictionary())
//                {
//                    success(json)
//                    return
//                }else if let strMsg = json?["message"] as? Int{
//                    let str  = String("\(strMsg)")
//                    failure(str)
//                    return
//                }
//            }
//            else if error!.localizedDescription.contains("JSON could not be serialized"){
//                failure("Problem in connecting to Server. Please try again!")
//            }else{
//                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
//            }
//        }
//    }
//    
//    func genrateVoiceCallingTokenVersion2(param : Dictionary<String,Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
//            ActivityIndicator.show()
//            print("Apphelper.Constants.API.generateVoicToken:-\(Apphelper.Constants.API.generateVoicToken)")
//            ServicesClass_New.getDataFromURlWithForUserDeatil(url:Apphelper.Constants.API.generateVoicToken, parameters: nil) { (json, error) in
//                
//                ActivityIndicator.hide()
//                
//                if error == nil
//                {
//    //                if self.isSuccess(info: json ?? Dictionary())
//    //                {
//    //                    success(json)
//    //                    return
//    //                }else if let strMsg = json?["message"] as? String{
//    //                    failure(strMsg)
//    //                    return
//    //                }
//                    
//                    success(json)
//
//                }
//                else if error!.localizedDescription.contains("JSON could not be serialized"){
//                    failure("Problem in connecting to Server. Please try again!")
//                }else{
//                    failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
//                }
//                
//            }
//            
//        }
//    func BidAcceptFromServer(param : Dictionary<String,Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
//        ActivityIndicator.show()
//        ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.accept_bid, parameters: param, requestName: "") { (json, error) in
//            ActivityIndicator.hide()
//            
//            if error == nil
//            {
//                if self.isSuccess(info: json ?? Dictionary())
//                {
//                    success(json)
//                    
//                    return
//                }else if let strMsg = json?["message"] as? String{
//                    failure(strMsg)
//                    return
//                }
//            }
//            else if error!.localizedDescription.contains("JSON could not be serialized"){
//                failure("Problem in connecting to Server. Please try again!")
//            }else{
//                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
//            }
//            
//        }
//    }
//    
//    func BidApplyFromServer(param : Dictionary<String,Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
//        ActivityIndicator.show()
//        ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.apply_bid, parameters: param, requestName: "") { (json, error) in
//            ActivityIndicator.hide()
//            
//            if error == nil
//            {
//                if self.isSuccess(info: json ?? Dictionary())
//                {
//                    success(json)
//                    return
//                }else if let strMsg = json?["message"] as? String{
//                    failure(strMsg)
//                    return
//                }
//            }
//            else if error!.localizedDescription.contains("JSON could not be serialized"){
//                failure("Problem in connecting to Server. Please try again!")
//            }else{
//                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
//            }
//            
//        }
//    }
//    
//    func requestPayment(param : Dictionary<String,Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
//        ActivityIndicator.show()
//        ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.requestPayment, parameters: param, requestName: "") { (json, error) in
//            ActivityIndicator.hide()
//            
//            if error == nil
//            {
//                if self.isSuccess(info: json ?? Dictionary())
//                {
//                    success(json)
//                    return
//                }else if let strMsg = json?["message"] as? String{
//                    failure(strMsg)
//                    return
//                }
//            }
//            else if error!.localizedDescription.contains("JSON could not be serialized"){
//                failure("Problem in connecting to Server. Please try again!")
//            }else{
//                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
//            }
//            
//        }
//    }
//    func WithdrawFromServer(param : Dictionary<String,Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
//        ActivityIndicator.show()
//        ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.withdraw , parameters: param, requestName: "") { (json, error) in
//            ActivityIndicator.hide()
//            
//            if error == nil
//            {
//                if self.isSuccess(info: json ?? Dictionary())
//                {
//                    success(json)
//                    return
//                }else if let strMsg = json?["message"] as? String{
//                    failure(strMsg)
//                    return
//                }
//            }
//            else if error!.localizedDescription.contains("JSON could not be serialized"){
//                failure("Problem in connecting to Server. Please try again!")
//            }else{
//                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
//            }
//            
//        }
//    }
//    
//    func workStatedFromServer(param : Dictionary<String,Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
//        ActivityIndicator.show()
//        
//        ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.start_work  , parameters: param, requestName: "") { (json, error) in
//            
//            ActivityIndicator.hide()
//            
//            if error == nil
//            {
//                if self.isSuccess(info: json ?? Dictionary())
//                {
//                    success(json)
//                    return
//                }else if let strMsg = json?["message"] as? String{
//                    failure(strMsg)
//                    return
//                }
//            }
//            else if error!.localizedDescription.contains("JSON could not be serialized"){
//                failure("Problem in connecting to Server. Please try again!")
//            }else{
//                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
//            }
//            
//        }
//        
//    }
//    
//    func getBidHistoryListFromServer( success : @escaping successBlock, failure : @escaping failureBlock)  {
//        ActivityIndicator.show()
//        
//        ServicesClass_New.getDataFromURlWith(url: Apphelper.Constants.API.bid_history, parameters: nil) { (json, error) in
//            
//            ActivityIndicator.hide()
//            
//            if error == nil
//            {
//                if self.isSuccess(info: json ?? Dictionary())
//                {
//                    success(json)
//                    return
//                }else if let strMsg = json?["message"] as? String{
//                    failure(strMsg)
//                    return
//                }
//            }
//            else if error!.localizedDescription.contains("JSON could not be serialized"){
//                failure("Problem in connecting to Server. Please try again!")
//            }else{
//                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
//            }
//            
//        }
//        
//    }
//    
//    func getReviewListFromServer(success : @escaping successBlock, failure : @escaping failureBlock)  {
//        ActivityIndicator.show()
//        let completeUrl = Apphelper.Constants.API.listing_reviews + "?seeker_id=\(DSUserPrefrence.user_ID)"
//        ServicesClass_New.getDataFromURlWith(url: completeUrl, parameters: nil) { (json, error) in
//            
//            ActivityIndicator.hide()
//            
//            if error == nil
//            {
//                if self.isSuccess(info: json ?? Dictionary())
//                {
//                    success(json)
//                    return
//                }else if let strMsg = json?["message"] as? String{
//                    failure(strMsg)
//                    return
//                }
//            }
//            else if error!.localizedDescription.contains("JSON could not be serialized"){
//                failure("Problem in connecting to Server. Please try again!")
//            }else{
//                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
//            }
//            
//        }
//        
//    }
//    
//    
//    func getReviewListFromServerProvider( seeker_id: Int,success : @escaping successBlock, failure : @escaping failureBlock)  {
//        ActivityIndicator.show()
//        
//        let completeUrl = Apphelper.Constants.API.listing_reviews + "?seeker_id=\(seeker_id)"
//        
//        ServicesClass_New.getDataFromURlWith(url: completeUrl, parameters: nil) { (json, error) in
//            
//            ActivityIndicator.hide()
//            
//            if error == nil
//            {
//                if self.isSuccess(info: json ?? Dictionary())
//                {
//                    success(json)
//                    return
//                }else if let strMsg = json?["message"] as? String{
//                    failure(strMsg)
//                    return
//                }
//            }
//            else if error!.localizedDescription.contains("JSON could not be serialized"){
//                failure("Problem in connecting to Server. Please try again!")
//            }else{
//                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
//            }
//            
//        }
//        
//    }
//    func getRecentClientListFromServer( success : @escaping successBlock, failure : @escaping failureBlock)  {
//        ActivityIndicator.show()
//        
//        ServicesClass_New.getDataFromURlWith(url: Apphelper.Constants.API.recent_clients, parameters: nil) { (json, error) in
//            
//            ActivityIndicator.hide()
//            
//            if error == nil
//            {
//                if self.isSuccess(info: json ?? Dictionary())
//                {
//                    success(json)
//                    return
//                }else if let strMsg = json?["message"] as? String{
//                    failure(strMsg)
//                    return
//                }
//            }
//            else if error!.localizedDescription.contains("JSON could not be serialized"){
//                failure("Problem in connecting to Server. Please try again!")
//            }else{
//                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
//            }
//            
//        }
//        
//    }
//    
//    func getProjectListingByStatusFromServer( _urlString: String , success : @escaping successBlock, failure : @escaping failureBlock) {
//        ActivityIndicator.show()
//        ServicesClass_New.getDataFromURlWith(url: _urlString, parameters: nil) { (json, error) in
//            
//            ActivityIndicator.hide()
//            
//            if error == nil
//            {
//                if self.isSuccess(info: json ?? Dictionary())
//                {
//                    success(json)
//                    return
//                }else if let strMsg = json?["message"] as? String{
//                    failure(strMsg)
//                    return
//                }
//            }
//            else if error!.localizedDescription.contains("JSON could not be serialized"){
//                failure("Problem in connecting to Server. Please try again!")
//            }else{
//                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
//            }
//            
//        }
//        
//    }
//    
//    
//    
//    func StripeInetegration(param : Dictionary<String,Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
//        
//        ActivityIndicator.show()
//        ServicesClass_New.postDataFromURLForaStripe(url: Apphelper.Constants.API.paymentCharge , parameters: param, requestName: "") { (json, error) in
//            
//            ActivityIndicator.hide()
//            
//            if error == nil
//            {
//                if self.isSuccess(info: json ?? Dictionary())
//                {
//                    
//                    success(json)
//                    return
//                }else if let strMsg = json?["message"] as? String{
//                    failure(strMsg)
//                    return
//                }
//            }
//            else if error!.localizedDescription.contains("JSON could not be serialized"){
//                failure("Problem in connecting to Server. Please try again!")
//            }else{
//                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
//            }
//            
//        }
//    }
//    
//    func getDeleteProjectrVideo(param : Dictionary<String,Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
//        ActivityIndicator.show()
//        ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.deleteProjectVideo , parameters: param, requestName: "") { (json, error) in
//            ActivityIndicator.hide()
//            
//            if error == nil
//            {
//                if self.isSuccess(info: json ?? Dictionary())
//                {
//                    success(json)
//                    return
//                }else if let strMsg = json?["message"] as? String{
//                    failure(strMsg)
//                    return
//                }
//            }
//            else if error!.localizedDescription.contains("JSON could not be serialized"){
//                failure("Problem in connecting to Server. Please try again!")
//            }else{
//                failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
//            }
//            
//        }
//    }
//    
//    func deletePortfilio(param : Dictionary<String,Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
//        ActivityIndicator.show()
//
//        ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.delete_port, parameters: param, requestName: "") { (json, error) in
//
//            ActivityIndicator.hide()
//
//            if error == nil
//            {
//                if self.isSuccess(info: json ?? Dictionary())
//                {
//                    success(json)
//                    return
//                }else if let strMsg = json?["message"] as? String{
//                    failure(strMsg)
//                    return
//                }
//            }
//           else if error!.localizedDescription.contains("JSON could not be serialized"){
//                failure("Problem in connecting to Server. Please try again!")
//            }else{
//                 failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
//            }
//
//        }
//    }
//    
//    func deleteLanguage(param : Dictionary<String,Any>, success : @escaping successBlock, failure : @escaping failureBlock)  {
//        ActivityIndicator.show()
//
//        ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.delete_language, parameters: param, requestName: "") { (json, error) in
//
//            ActivityIndicator.hide()
//
//            if error == nil
//            {
//                if self.isSuccess(info: json ?? Dictionary())
//                {
//                    success(json)
//                    return
//                }else if let strMsg = json?["message"] as? String{
//                    failure(strMsg)
//                    return
//                }
//            }
//           else if error!.localizedDescription.contains("JSON could not be serialized"){
//                failure("Problem in connecting to Server. Please try again!")
//            }else{
//                 failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
//            }
//
//        }
//    }
//    func getDeleteReviewVideo(param : Dictionary<String,Any>, success : @escaping successBlock, failure : @escaping failureBlock) {
//    ActivityIndicator.show()
//    ServicesClass_New.postDataFromURL(url: Apphelper.Constants.API.delete_review , parameters: param, requestName: "") { (json, error) in
//    ActivityIndicator.hide()
//
//    if error == nil
//    {
//    if self.isSuccess(info: json ?? Dictionary())
//    {
//    success(json)
//    return
//    }else if let strMsg = json?["message"] as? String{
//    failure(strMsg)
//    return
//    }
//    }
//    else if error!.localizedDescription.contains("JSON could not be serialized"){
//    failure("Problem in connecting to Server. Please try again!")
//    }else{
//    failure(error != nil ? error!.localizedDescription : Apphelper.Constants.FailureMessage.otpVerify)
//    }
//
//    }
//    }
}


    





