//
//  OtpVerificationVC.swift
//  Ride-Share FR
//
//  Created by Priya Rastogi on 23/06/22.
//

import UIKit
import PinCodeTextField
@available(iOS 13.0, *)
class OtpVerificationVC: UIViewController {

    @IBOutlet weak var pinCodeTxt: PinCodeTextField!
    
    var type = ""
    
//    var isCameFromSignUp = false
//    var pinCodeValue  = "0"
//    var strotp : String?
//    var strMobileNo : String?
//    var email : String?
//    var password : String?
    var isOTPForgot : Bool = Bool()
    var countryCode : String?
    var countryFlag : String?
    lazy var email : String = String()
    lazy var name : String = String()

    lazy var mobileNumber : String = String()
    lazy var systemOTP : String = String()
    lazy var password : String = String()
    var isFromHome:Bool =  false
    var strCountryCode = "+1"
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func verifyOtpApi(){
        var dicParam : Dictionary<String,Any> = Dictionary()
        
        dicParam["otp"] = pinCodeTxt.text
        dicParam["email"] = self.email
        AppServices.shared.verifyOTP(param: dicParam, success: { (data) in
            print("datadatadata:-",data)
            self.moveToReset()

        
        }, failure: {errorMsg in })
    }
    
    
    func moveToReset() {
    if type == "sign" {
     let vc = self.storyboard?.instantiateViewController(withIdentifier: "VehicleDetailsVC") as! VehicleDetailsVC
        vc.name = self.name
        vc.email = self.email
    
    self.navigationController?.pushViewController(vc, animated: true)
        
    }else{
    let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResetPasswordVC") as! ResetPasswordVC
    vc.email = self.email
    vc.mobile = self.mobileNumber
        
    self.navigationController?.pushViewController(vc, animated: true)
      }
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func resendOtpBtn(_ sender: Any) {
        
        var dicParam : Dictionary<String,Any> = Dictionary()
        dicParam["name"] = name
        dicParam["email"] = email
      
        dicParam["mobile"] = mobileNumber
        AppServices.shared.resendSmsOtp(dicParam: dicParam, success: { (data, strOTP) in
            print("datadatadata:-",data)
            
        }, failure: {errorMsg in
            self.showOkAlert(errorMsg)
        })
    }
    @IBAction func verifyOtpBtn(_ sender: Any) {
        verifyOtpApi()

}
}
