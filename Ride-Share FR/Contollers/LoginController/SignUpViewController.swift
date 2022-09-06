//
//  SignUpViewController.swift
//  Ride-Share FR
//
//  Created by Priya Rastogi on 23/06/22.
//

import UIKit
import GoogleMaps
import GooglePlaces
@available(iOS 13.0, *)
class SignUpViewController: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtNumber: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var txtServiceArea: UITextField!
    @IBOutlet weak var checkBtn: UIButton!
    @IBOutlet weak var btnShowPassword: UIButton!
    @IBOutlet weak var btnShowConfirmPassword: UIButton!
    @IBOutlet weak var txtCountryCode: UILabel!
    
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var lastNameView: UIView!
    @IBOutlet weak var numberView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var confirmView: UIView!
    @IBOutlet weak var serviesView: UIView!
    
    
    var isChecked = false
    var isComing = "sign"
    var locationManager : CLLocationManager!
    var arrCodinate = [String]()
    var gmsAddress : GMSAddress?
    var countryCodeSign = "+1"
    var lat: String?
    var long: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        load()
    
        btnShowPassword.isSelected = true
        txtPassword.isSecureTextEntry = true
        btnShowConfirmPassword.isSelected = true
        txtConfirmPassword.isSecureTextEntry = true
        self.countryCodeSign = "+1"

        // Do any additional setup after loading the view.
    }
    func load() {
        nameView.layer.borderColor = #colorLiteral(red: 0.7482101321, green: 0.7533286214, blue: 0.7227731347, alpha: 1)
        lastNameView.layer.borderColor = #colorLiteral(red: 0.7482101321, green: 0.7533286214, blue: 0.7227731347, alpha: 1)
        numberView.layer.borderColor = #colorLiteral(red: 0.7482101321, green: 0.7533286214, blue: 0.7227731347, alpha: 1)
        emailView.layer.borderColor = #colorLiteral(red: 0.7482101321, green: 0.7533286214, blue: 0.7227731347, alpha: 1)
        passwordView.layer.borderColor = #colorLiteral(red: 0.7482101321, green: 0.7533286214, blue: 0.7227731347, alpha: 1)
        confirmView.layer.borderColor = #colorLiteral(red: 0.7482101321, green: 0.7533286214, blue: 0.7227731347, alpha: 1)
        serviesView.layer.borderColor = #colorLiteral(red: 0.7482101321, green: 0.7533286214, blue: 0.7227731347, alpha: 1)
        nameView.layer.borderWidth = 1
        lastNameView.layer.borderWidth = 1
        numberView.layer.borderWidth = 1
        emailView.layer.borderWidth = 1
        passwordView.layer.borderWidth = 1
        confirmView.layer.borderWidth = 1
        serviesView.layer.borderWidth = 1
    }

    func SignUp(){
        var dicParam : Dictionary<String,Any> = Dictionary()
    
        dicParam["name"] = txtName.text!
        
        dicParam["email"] = txtEmail.text!
        dicParam["password"] = txtPassword.text!
        dicParam["password"] = txtConfirmPassword.text!
        dicParam["country_code"] = self.countryCodeSign//txtCountryCode.text!
        dicParam["mobile_number"] = txtNumber.text!
        dicParam["serviceArea"] = (gmsAddress?.lines?.joined(separator: "/n"))
        dicParam["latitude"] = self.lat
        dicParam["longitude"] = self.long
        dicParam["user_type"] = "driver"

    

        AppServices.shared.registerUser(dicParam: dicParam, success: { (data, strOTP) in
            print("datadatadata:-",data)
            DispatchQueue.main.async {
                let controller : OtpVerificationVC = self.storyboard?.instantiateViewController(withIdentifier: "OtpVerificationVC") as! OtpVerificationVC
              
                controller.isOTPForgot = false
                controller.type = "sign"
                controller.name = self.txtName.text!
                controller.email = self.txtEmail.text!
                controller.mobileNumber = self.txtNumber.text!
                controller.password = self.txtPassword.text!
                controller.strCountryCode = self.countryCodeSign
            
                self.navigationController?.pushViewController(controller, animated: true)
            }

        }, failure: {errorMsg in
            self.showOkAlert(errorMsg)
        })
    }

    
    @IBAction func btnActionServiceArea(_ sender: UIButton) {
        let locationGetViewController = self.storyboard?.instantiateViewController(withIdentifier: "LocationGetViewController") as! LocationGetViewController
       
        locationGetViewController.delegateLocation = self
        self.navigationController?.pushViewController(locationGetViewController, animated: true)
    }
    
    @IBAction func btnShowPasswordTapped(_ sender: Any) {
        btnShowPassword.isSelected = !btnShowPassword.isSelected
        if btnShowPassword.isSelected {
            txtPassword.isSecureTextEntry = true
            btnShowPassword.setImage(#imageLiteral(resourceName: "eye_off_ic"), for: .normal)
        }else{
            txtPassword.isSecureTextEntry = false
            btnShowPassword.setImage(#imageLiteral(resourceName: "eye_on_ic"), for: .normal)
        }
    }
    
    @IBAction func btnShowConfirmPasswordTapped(_ sender: Any) {
        btnShowConfirmPassword.isSelected = !btnShowConfirmPassword.isSelected
        if btnShowConfirmPassword.isSelected {
            txtConfirmPassword.isSecureTextEntry = true
            btnShowConfirmPassword.setImage(#imageLiteral(resourceName: "eye_off_ic"), for: .normal)
        }else{
            txtConfirmPassword.isSecureTextEntry = false
            btnShowConfirmPassword.setImage(#imageLiteral(resourceName: "eye_on_ic"), for: .normal)
        }
    }
    
    
    @IBAction func termServiceTapped(_ sender: Any) {
        print("TappedTappedTapped")
        if isChecked == true{
            checkBtn.setImage(UIImage(named: "chech_off_ic"), for: .normal)
            isChecked = false
            
        }else{
            checkBtn.setImage(UIImage(named: "chech_on_ic"), for: .normal)
            isChecked = true
        }

    }
    

    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func continueBtn(_ sender: Any) {
        self.view.endEditing(true)
        if self.validation(){
            if isChecked == true{
                self.SignUp()
            } else {
                showOkAlert("Please accept the term and condtions.")
            }
//            self.SignUp()
        }
        
    }
    @IBAction func loginBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
@available(iOS 13.0, *)
extension SignUpViewController : LocationGetControllerDelegate{
   
    
    func locationGetData(addressString: GMSAddress?) {
        if (addressString != nil) {
            self.gmsAddress = addressString
            self.txtServiceArea.text = addressString?.lines!.joined(separator: "\n")
//            let strLat = String(describing: /(addressString?.coordinate.latitude))
//            let strLong = String(describing: /(addressString?.coordinate.longitude))
            if let templat = addressString?.coordinate.latitude {
                self.lat = String(templat)
                self.arrCodinate.append(self.lat!)
            }
            if let temlong = addressString?.coordinate.longitude {
                self.long = String(temlong)
                self.arrCodinate.append(self.long!)
            }
           // self.lat = String(describing: (addressString?.coordinate.latitude))
           // self.long = String(describing: (addressString?.coordinate.longitude))
          //  self.arrCodinate = [self.lat,self.long]
        }
    }
    
    
}



@available(iOS 13.0, *)
extension SignUpViewController : UITextFieldDelegate{
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == txtName){
            txtName.resignFirstResponder()
            txtLastName.becomeFirstResponder()
            
        }
        else if (textField == txtLastName){
            txtLastName.resignFirstResponder()
            txtNumber.becomeFirstResponder()
            
        }
        else if (textField == txtNumber){
            txtNumber.resignFirstResponder()
            txtEmail.becomeFirstResponder()
            
        }
        else if (textField == txtEmail){
            txtEmail.resignFirstResponder()
            txtPassword.becomeFirstResponder()
            
        }
        else if (textField == txtPassword){
            txtPassword.resignFirstResponder()
            txtConfirmPassword.becomeFirstResponder()
            
        }
        else if (textField == txtConfirmPassword){
            txtConfirmPassword.resignFirstResponder()
            txtServiceArea.becomeFirstResponder()
            
        }
        else if (textField == txtServiceArea){
            txtServiceArea.resignFirstResponder()
        //    txtNumber.becomeFirstResponder()
            
        }

        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
  
        if textField == txtName {
            nameView.layer.borderColor = #colorLiteral(red: 0.06241328269, green: 0.1183073893, blue: 0.1983669996, alpha: 1)
            nameView.layer.borderWidth = 1
        }
        else if textField == txtLastName {
            lastNameView.layer.borderColor = #colorLiteral(red: 0.06241328269, green: 0.1183073893, blue: 0.1983669996, alpha: 1)
            lastNameView.layer.borderWidth = 1
        }
        else if textField == txtNumber {
            numberView.layer.borderColor = #colorLiteral(red: 0.06241328269, green: 0.1183073893, blue: 0.1983669996, alpha: 1)
            numberView.layer.borderWidth = 1
        }
        else if textField == txtEmail {
            emailView.layer.borderColor = #colorLiteral(red: 0.06241328269, green: 0.1183073893, blue: 0.1983669996, alpha: 1)
            emailView.layer.borderWidth = 1
        }
        else if textField == txtPassword {
            passwordView.layer.borderColor = #colorLiteral(red: 0.06241328269, green: 0.1183073893, blue: 0.1983669996, alpha: 1)
            passwordView.layer.borderWidth = 1
        }
        else if textField == txtConfirmPassword {
            confirmView.layer.borderColor = #colorLiteral(red: 0.06241328269, green: 0.1183073893, blue: 0.1983669996, alpha: 1)
            confirmView.layer.borderWidth = 1
        }
        else if textField == txtServiceArea {
            serviesView.layer.borderColor = #colorLiteral(red: 0.06241328269, green: 0.1183073893, blue: 0.1983669996, alpha: 1)
            serviesView.layer.borderWidth = 1
        }
      
    }
}

@available(iOS 13.0, *)
extension SignUpViewController {
    func validation() -> Bool
    {
        if (txtName.text?.isEmpty)!
        {
            self.showOkAlertWithHandler(Apphelper.Constants.MessageConstant.requireFirstName) {
            }
            return false
        }
        else if (txtLastName.text?.isEmpty)!
        {
           self.showOkAlertWithHandler(Apphelper.Constants.MessageConstant.requireLastName) {
            }
            return false
            
        }
        else if (txtNumber.text?.isEmpty)!
        {
           self.showOkAlertWithHandler(Apphelper.Constants.MessageConstant.requirePhoneNumber) {
            }
            return false
            
        }
        else if (txtEmail.text?.isEmpty)!
        {
           self.showOkAlertWithHandler(Apphelper.Constants.MessageConstant.requireEmail) {
            }
            return false
            
        }
        else if (txtPassword.text?.isEmpty)!
        {
           self.showOkAlertWithHandler(Apphelper.Constants.MessageConstant.requirePassword) {
            }
            return false
            
        }
        else if (txtConfirmPassword.text?.isEmpty)!
        {
           self.showOkAlertWithHandler(Apphelper.Constants.MessageConstant.requireConfirmPassword) {
            }
            return false
            
        }
        else if (txtServiceArea.text?.isEmpty)!
        {
           self.showOkAlertWithHandler(Apphelper.Constants.MessageConstant.requireAddress) {
            }
            return false
            
        }
        return true
        
    }
}
