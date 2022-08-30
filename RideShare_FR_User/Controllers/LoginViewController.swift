//
//  LoginViewController.swift
//  Ride-Share FR
//
//  Created by Priya Rastogi on 22/06/22.
//

import UIKit

@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
class LoginViewController: UIViewController {

    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnShowPassword: UIButton!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        emailView.layer.borderColor = #colorLiteral(red: 0.7482101321, green: 0.7533286214, blue: 0.7227731347, alpha: 1)
        passwordView.layer.borderColor = #colorLiteral(red: 0.7482101321, green: 0.7533286214, blue: 0.7227731347, alpha: 1)
        emailView.layer.borderWidth = 1
        passwordView.layer.borderWidth = 1
        btnShowPassword.isSelected = true
        txtPassword.isSecureTextEntry = true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // self.txtEmail.text = nil
       // self.txtPassword.text = nil
    }
    
    
    
    func apiCallForLogin() {
        var dicParam : Dictionary<String,Any> = Dictionary()
               dicParam["email"] = txtEmail.text ?? ""
               dicParam["password"] = txtPassword.text! //.trimmedText()
               dicParam["device_id"] = DSUserPrefrence.device_token
               dicParam["device_type"] = "ios"
               dicParam["user_type"] = "user"
        

             //  dicParam["device_token"] =     DSUserPrefrence.device_token//"vrbvbrbvrb"///DSUserPrefrence.device_token
               print("dicParamdicParamdicParam:-\(dicParam)")
        AppServices.shared.login(param: dicParam, success: {  (data) in
            print("datadata-\(data)")
            
            let dictdata = data as! [String : Any]
            Facade.shared.authToken = dictdata["token"] as? String

            let dataObj = dictdata["data"] as! [String : Any]
            DSUserPrefrence.FullName = dataObj["name"] as! String
            DSUserPrefrence.profilePicture = dataObj["profile_pic"] as! String
            DSUserPrefrence.email_address = dataObj["email"] as! String
            DSUserPrefrence.user_ID = dataObj["_id"] as! String
            DSUserPrefrence.device_id = dataObj["device_id"] as! String
            DSUserPrefrence.country_code = dataObj["country_code"] as! String
            DSUserPrefrence.mobile_number = dataObj["mobile_number"] as! String
            DSUserPrefrence.userType = dataObj["user_type"] as? String ?? ""
         //   DSUserPrefrence.credential_status = dataObj["credential_status"] as! String
         //   DSUserPrefrence.qualification_status = dataObj["qualification_status"] as! String
            DSUserPrefrence.Token = dataObj["token"] as? String ?? ""
            
            //UserDefaults.standard.setValue(self.txtPassword.text?.trimmedText(), forKey: "password")
    
//                DispatchQueue.main.async {
//                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
//                    self.navigationController?.pushViewController(vc, animated: true)
//                }
            self.moveDashboard()
          
        }, failure: {errorMsg in
            self.showOkAlert(errorMsg)
        })
    }
    
    
    func moveDashboard() {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LocationDemoViewController") as! LocationDemoViewController
        self.navigationController?.pushViewController(vc, animated: true)
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
    
    @IBAction func forgetPasswordBtn(_ sender: Any) {
        //if Validation1() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ForgetPasswordVC") as! ForgetPasswordVC
        self.navigationController?.pushViewController(vc, animated: true)
      //  }
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        self.view.endEditing(true)
        if self.Validation(){
            self.apiCallForLogin()
        }
    }
    @IBAction func createAccountBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
}


@available(iOS 13.0, *)
extension LoginViewController : UITextFieldDelegate{
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == txtEmail){
            txtEmail.resignFirstResponder()
            txtPassword.becomeFirstResponder()
            
        }
        else if (textField == txtPassword){
            txtPassword.resignFirstResponder()
            
        }

        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
  
        if textField == txtEmail {
            emailView.layer.borderColor = #colorLiteral(red: 0.06241328269, green: 0.1183073893, blue: 0.1983669996, alpha: 1)
            emailView.layer.borderWidth = 1
        }
        else if textField == txtPassword {
            passwordView.layer.borderColor = #colorLiteral(red: 0.06241328269, green: 0.1183073893, blue: 0.1983669996, alpha: 1)
            passwordView.layer.borderWidth = 1
        }
        else if textField == txtPassword {
        //    vV3.layer.borderColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
         //   vV3.layer.borderWidth = 2
        }
      
    }
}
@available(iOS 13.0, *)
extension LoginViewController {
    func Validation()-> Bool {
        if (txtEmail.text?.isEmpty)! {
            self.showOkAlertWithHandler(Apphelper.Constants.MessageConstant.requireEmail) {
            }
            return false
        }
        else if (txtPassword.text?.isEmpty)! {
            self.showOkAlertWithHandler(Apphelper.Constants.MessageConstant.requirePassword) {
        }
        return false
        }
        return true
    }
}

@available(iOS 13.0, *)
extension LoginViewController {
    func Validation1()-> Bool {
        if (txtEmail.text?.isEmpty)! {
            self.showOkAlertWithHandler(Apphelper.Constants.MessageConstant.requireEmail) {
            }
            return false
        }
        
        return true
    }
}




